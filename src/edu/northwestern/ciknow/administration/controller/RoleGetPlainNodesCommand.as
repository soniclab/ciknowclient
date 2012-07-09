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

	public class RoleGetPlainNodesCommand
	{
		private static var logger:ILogger = LogUtil.getLog(RoleGetPlainNodesCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="roleRO")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;
		
		public function RoleGetPlainNodesCommand()
		{
		}
		
		public function execute(event:RoleEvent):AsyncToken{
			var roleId:String = String(event.data.roleId);
			logger.info("Get plain nodes by roleId: " + roleId);
			return service.getPlainNodesByRoleId(roleId);
		}
		
		public function result(event:ResultEvent, trigger:RoleEvent):void{	
			logger.info("Got plain nodes by roleId.");
			var nodes:ArrayCollection = ArrayCollection(event.result);
			nodes.sort = gu.getSort("label");
			nodes.refresh();
			
			var e:RoleEvent = new RoleEvent(RoleEvent.GOT_PLAIN_NODES_BY_ROLE_ID);
			e.data = new Object();
			e.data.nodes = nodes;
			e.data.roleId = String(trigger.data.roleId);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:RoleEvent):void{
			gu.handleFault(event.fault);
		}
	}
}