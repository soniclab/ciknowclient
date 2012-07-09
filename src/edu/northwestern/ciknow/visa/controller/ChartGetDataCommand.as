package edu.northwestern.ciknow.visa.controller
{
	import edu.northwestern.ciknow.common.events.QuestionEvent;
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
	
	public class ChartGetDataCommand
	{
		private static var logger:ILogger = LogUtil.getLog(ChartGetDataCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="questionRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function ChartGetDataCommand()
		{
		}
		
		public function execute(event:QuestionEvent):AsyncToken{
			logger.info("Get chart data...");
			return service.getChartData(event.data);
		}
		
		public function result(event:ResultEvent, trigger:QuestionEvent):void{					
			var e:QuestionEvent = new QuestionEvent(QuestionEvent.GOT_CHART_DATA);
			e.data = event.result;
			dispatcher(e);
			logger.info("Got chart data.");
		}
		
		public function error(event:FaultEvent, trigger:QuestionEvent):void{
			gu.handleFault(event.fault);
		}
	}
}