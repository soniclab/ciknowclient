package edu.northwestern.ciknow.administration.controller
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
	
	public class InviteUsersCommand
	{
		private static var logger:ILogger = LogUtil.getLog(InviteUsersCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function InviteUsersCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Inviting users...");
			return service.inviteUsers(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			var nodeIds:ArrayCollection = event.result as ArrayCollection;
			Alert.show(nodeIds.length + " active nodes have been invited via email. " + 
				"If the count is not what you expected, please double check " + 
				"whether each node is active/enabled, and have valid email address.");				
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}