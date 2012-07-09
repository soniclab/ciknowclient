package edu.northwestern.ciknow.visa.controller
{
	import edu.northwestern.ciknow.common.events.NetworkAnalyticsEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class GetNetworkMetricsCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GetNetworkMetricsCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="networkAnalyticsRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function GetNetworkMetricsCommand()
		{
		}
		
		public function execute(event:NetworkAnalyticsEvent):AsyncToken{
			logger.info("Get network analytics...");
			return service.getNetworkMetrics(event.data);
		}
		
		public function result(event:ResultEvent, trigger:NetworkAnalyticsEvent):void{		
			logger.info("Got network analytics.");
			var e:NetworkAnalyticsEvent = new NetworkAnalyticsEvent(NetworkAnalyticsEvent.GOT_NETWORK_METRICS);
			e.data = event.result;
			dispatcher(e);					
		}
		
		public function error(event:FaultEvent, trigger:NetworkAnalyticsEvent):void{
			gu.handleFault(event.fault);
		}
	}
}