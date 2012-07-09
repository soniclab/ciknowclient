package edu.northwestern.ciknow.common.controller
{
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

	public class UpdatePasswordCommand
	{
		private static const logger:ILogger = LogUtil.getLog(UpdatePasswordCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var model:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function UpdatePasswordCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("update password...");
			return service.updatePassword(event.data);
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{
			var result:Object = event.result;
			if(result.hasOwnProperty("node")){
				var node:NodeDTO = NodeDTO(result.node);
				
				// TODO: add a message listener for this
				/* 
				if (model.currentNodeDTO != null && model.currentNodeDTO.nodeId == node.nodeId){
					model.currentNodeDTO.password = node.password;
					model.currentNodeDTO.version = node.version;								
				}
				*/
				if (model.loginNode != null && model.loginNode.nodeId == node.nodeId){
					model.loginNode.password = node.password;
					model.loginNode.version = node.version;
				}		
				
				Alert.show(node.username + " password updated.");
				dispatcher(new NodeEvent(NodeEvent.UPDATED_PASSWORD));
			} else {
				var msg:String = String(result.msg);
				Alert.show(msg, "Error");
			}
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}