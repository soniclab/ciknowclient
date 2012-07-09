package edu.northwestern.ciknow.administration.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.administration.presentation.node.NodePM;
	import edu.northwestern.ciknow.common.domain.NodeDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.NodeEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class CheckUsernameAvailabilityCommand
	{
		private static var logger:ILogger = LogUtil.getLog(CheckUsernameAvailabilityCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;
		
		public function CheckUsernameAvailabilityCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.debug("Checking availability of username: " + event.data);
			return service.getNodebyUsername(String(event.data));
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{	
			var result:Object = event.result;
			if (result != null) {
				Alert.show("Username (" + trigger.data + ") has ready been taken.");
			} else {
				Alert.show("Username (" + trigger.data + ") is available.");
			}
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}