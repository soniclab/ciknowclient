package edu.northwestern.ciknow.visa.controller
{
	import edu.northwestern.ciknow.common.events.GeneralEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class LargeNetworkLimitsGetCommand
	{
		private static var logger:ILogger = LogUtil.getLog(LargeNetworkLimitsGetCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function LargeNetworkLimitsGetCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get large network limits...");
			return service.getLargeNetworkLimits();
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			logger.info("Got large network limits.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GOT_LARGE_NETWORK_LIMITS);
			e.data = event.result;			
			dispatcher(e);					
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}