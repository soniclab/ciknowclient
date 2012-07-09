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
	
	public class LargeNetworkLimitsSetCommand
	{
		private static var logger:ILogger = LogUtil.getLog(LargeNetworkLimitsSetCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function LargeNetworkLimitsSetCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Set large network limits...");
			return service.setLargeNetworkLimits(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			Alert.show("Network limits set successfully.");				
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}