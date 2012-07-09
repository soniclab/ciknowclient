package edu.northwestern.ciknow.administration.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.common.domain.RoleDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.RoleEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	import edu.northwestern.ciknow.common.util.RoleUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class RoleDeleteCommand
	{
		private static var logger:ILogger = LogUtil.getLog(RoleDeleteCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="roleRO")]
		public var service:RemoteObject;
		
		[Inject(id="roleCache")]
		public var roleCache:IDataCache;
		
		[Inject]
		public var sm:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil
		
		public function RoleDeleteCommand()
		{
		}
		
		public function execute(event:RoleEvent):AsyncToken{
			logger.info("Deleting role...");
			return service.deleteRole(RoleDTO(event.data).roleId);
		}
		
		public function result(event:ResultEvent, trigger:RoleEvent):void{
			var roleId:Number = Number(event.result);
			var role:RoleDTO = RoleDTO(trigger.data);			
			logger.debug("Role (" + role.name + ") is deleted successfully.");
			
			roleCache.clearItem(role);
			sm.roles.removeItemAt(sm.roles.getItemIndex(role));

			var index:Number = sm.loginNode.roles.getItemIndex(roleId);
			if (index >= 0){
				logger.debug("loginNode is removed from deleted role.");
				sm.loginNode.roles.removeItemAt(index);
				sm.loginNode.version += 1;
			}
							
			var e:RoleEvent = new RoleEvent(RoleEvent.DELETE_ROLE_DONE);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:RoleEvent):void{
			gu.handleFault(event.fault);
		}
	}
}