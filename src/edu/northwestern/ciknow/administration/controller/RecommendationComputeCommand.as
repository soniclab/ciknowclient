package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.RecommendationEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import spark.collections.Sort;

	public class RecommendationComputeCommand
	{
		private static var logger:ILogger = LogUtil.getLog(RecommendationComputeCommand);
		
		private var source:String = null;
		private var dirtyonly:String = null;
		private var row:String = null;
		private var col:String = null;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="recommenderService")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;

		[Inject]
		public var sm:SharedModel;
		
		public function RecommendationComputeCommand()
		{
			
		}
		
		public function execute(event:RecommendationEvent):AsyncToken{
			var d:Object = event.data;
			source = String(d.source);
			dirtyonly = String(d.dirtyonly);
			if (d.hasOwnProperty("row")) row = String(d.row);
			if (d.hasOwnProperty("col")) col = String(d.col);				
			logger.debug("Calculating (source=" + source + ", row=" + row + ", col=" + col + ")");
			
			return service.computeRec(event.data);
		}
		
		public function result(event:ResultEvent, trigger:RecommendationEvent):void{
			var x:XML = new XML(event.result);
			
			var e:RecommendationEvent = new RecommendationEvent(RecommendationEvent.COMPUTED_RECOMMENDATIONS);
			e.data.success = "1";
			e.data.source = source;
			e.data.row = row;
			e.data.col = col;
			
			var pair:XML;
			var xpair:XML;
			var lastSavedMetrics:String = x[source].@lastSavedMetrics;
			if (lastSavedMetrics == null || lastSavedMetrics.length == 0) lastSavedMetrics = "0";
			
			if (row != null && col != null){
				pair = sm.recConfigXML[source].pair.(@row == row && @col == col)[0];
				xpair = x[source].pair.(@row == row && @col == col)[0];
				pair.@lastCalcTime = xpair.@lastCalcTime;
				pair.@dirty = xpair.@dirty;
				e.data.msg = lastSavedMetrics + " metrics are created for (source=" + source + ", row=" + row + ", col=" + col + ")";
			} else {
				for each (pair in sm.recConfigXML[source].pair){
					for each (xpair in x[source].pair){
						if (pair.@row == xpair.@row && pair.@col == xpair.@col){
							pair.@lastCalcTime = xpair.@lastCalcTime;
							pair.@dirty = xpair.@dirty;
							break;
						}
					}
				}
				e.data.msg = lastSavedMetrics + " metrics are created for (source=" + source + ")";
			}
			
			dispatcher(e);		
		}
		
		public function error(event:FaultEvent, trigger:RecommendationEvent):void{
			var e:RecommendationEvent = new RecommendationEvent(RecommendationEvent.COMPUTED_RECOMMENDATIONS);
			e.data.success = "0";						
			e.data.source = source;
			e.data.row = row;
			e.data.col = col;
			e.data.msg = event.fault.faultString;
			dispatcher(e);
		}
	}
}