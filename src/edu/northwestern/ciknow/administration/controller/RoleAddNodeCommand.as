package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.domain.NodeDTO;
	import edu.northwestern.ciknow.common.domain.RoleDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.RoleEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class RoleAddNodeCommand
	{
		private static var logger:ILogger = LogUtil.getLog(RoleAddNodeCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="roleRO")]
		public var service:RemoteObject;

		[Inject]
		public var sm:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function RoleAddNodeCommand()
		{
		}
		
		public function execute(event:RoleEvent):AsyncToken{
			logger.info("Add nodes to role...");
			return service.addNodeToRole(event.data);
		}
		
		public function result(event:ResultEvent, trigger:RoleEvent):void{	
			var roleId:String = String(event.result.roleId);
			var nodeIds:ArrayCollection = ArrayCollection(event.result.nodeIds);
			logger.debug("Added nodes (" + nodeIds + ") to role: " + roleId);
			
			// update loginNode?
			if (!sm.loginNode.roles.contains(Number(roleId)) &&
				nodeIds.contains(sm.loginNode.nodeId.toString())){
				logger.debug("loginNode is added to role.");
				sm.loginNode.roles.addItem(Number(roleId));
				sm.loginNode.version += 1;
			}
			
			// not necessary
			/*
			var e:RoleEvent = new RoleEvent(RoleEvent.ADDED_NODE_TO_ROLE);
			e.data = event.result;
			dispatcher(e);	
			*/
		}
		
		public function error(event:FaultEvent, trigger:RoleEvent):void{
			gu.handleFault(event.fault);
			
			// reset
			var e:RoleEvent = new RoleEvent(RoleEvent.GET_PLAIN_NODES_BY_ROLE_ID);
			e.data.roleId = String(trigger.data.roleId);
			dispatcher(e);
		}
	}
}