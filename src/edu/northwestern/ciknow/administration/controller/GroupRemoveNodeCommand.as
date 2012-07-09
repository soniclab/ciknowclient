package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.domain.GroupDTO;
	import edu.northwestern.ciknow.common.domain.NodeDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.GroupEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import flash.text.engine.GroupElement;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class GroupRemoveNodeCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GroupRemoveNodeCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="groupRO")]
		public var service:RemoteObject;

		[Inject]
		public var sm:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function GroupRemoveNodeCommand()
		{
		}
		
		public function execute(event:GroupEvent):AsyncToken{
			logger.info("Remove nodes from group...");
			return service.removeNodeFromGroup(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GroupEvent):void{	
			var groupId:String = String(event.result.groupId);
			var nodeIds:ArrayCollection = ArrayCollection(event.result.nodeIds);
			logger.debug("Removed nodes (" + nodeIds + ") from group: " + groupId);
			
			// update loginNode?
			if (sm.loginNode.groups.contains(Number(groupId)) &&
				nodeIds.contains(sm.loginNode.nodeId.toString())){
				logger.debug("loginNode is removed from group.");
				sm.loginNode.groups.removeItemAt(sm.loginNode.groups.getItemIndex(Number(groupId)));
				sm.loginNode.version += 1;
			}
		}
		
		public function error(event:FaultEvent, trigger:GroupEvent):void{
			gu.handleFault(event.fault);
			
			// reset
			var e:GroupEvent = new GroupEvent(GroupEvent.GET_PLAIN_NODES_BY_GROUP_ID);
			e.data.groupId = String(trigger.data.groupId);
			dispatcher(e);
		}
	}
}