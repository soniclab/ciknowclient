package edu.northwestern.ciknow.visa.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.common.events.GeneralEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	import edu.northwestern.ciknow.visa.presentation.savedvis.SavedVisualizationPM;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class VisGetVisibleCommand
	{
		private static var logger:ILogger = LogUtil.getLog(VisGetVisibleCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var svPM:SavedVisualizationPM;
		
		[Inject(id="savedVisualizationCache")]
		public var svCache:IDataCache;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function VisGetVisibleCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get visible vis...");
			return service.getVisibleVisualization(event.data.nodeId);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{					
			var viss:IList = svCache.synchronize(ArrayCollection(event.result));
			for each (var vis:Object in viss){
				if (svPM.visibleViss.getItemIndex(vis) < 0) svPM.visibleViss.addItem(vis);
			}
			logger.info("Got visible viss: " + viss.length);
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}