package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.domain.GroupDTO;
	import edu.northwestern.ciknow.common.domain.NodeDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.GroupEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class GroupAddNodeCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GroupAddNodeCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="groupRO")]
		public var service:RemoteObject;

		[Inject]
		public var sm:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function GroupAddNodeCommand()
		{
		}
		
		public function execute(event:GroupEvent):AsyncToken{
			logger.info("Add nodes to group...");
			return service.addNodeToGroup(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GroupEvent):void{	
			var groupId:String = String(event.result.groupId);
			var nodeIds:ArrayCollection = ArrayCollection(event.result.nodeIds);
			logger.debug("Added nodes (" + nodeIds + ") to group: " + groupId);
			
			// update loginNode?
			if (!sm.loginNode.groups.contains(Number(groupId)) &&
				nodeIds.contains(sm.loginNode.nodeId.toString())){
				logger.debug("loginNode is added to group.");
				sm.loginNode.groups.addItem(Number(groupId));
				sm.loginNode.version += 1;
			}
			
			// not necessary
			/*
			var e:GroupEvent = new GroupEvent(GroupEvent.ADDED_NODE_TO_GROUP);
			e.data = event.result;
			dispatcher(e);	
			*/
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