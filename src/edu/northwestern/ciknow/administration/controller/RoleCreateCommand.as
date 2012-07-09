package edu.northwestern.ciknow.administration.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
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

	public class RoleCreateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(RoleCreateCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="roleRO")]
		public var service:RemoteObject;
		
		[Inject(id="roleCache")]
		public var roleCache:IDataCache;
		
		[Inject]
		public var sm:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function RoleCreateCommand()
		{
		}
		
		public function execute(event:RoleEvent):AsyncToken{
			logger.info("Creating role...");
			return service.createRole(RoleDTO(event.data));
		}
		
		public function result(event:ResultEvent, trigger:RoleEvent):void{
			var role:RoleDTO = RoleDTO(event.result);
			logger.debug("New Role (" + role.name + ") is created successfully.");
			
			role = RoleDTO(roleCache.synchronizeItem(role));
			sm.roles.addItem(role);
			
			var e:RoleEvent = new RoleEvent(RoleEvent.CREATE_ROLE_DONE);
			e.data = role;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:RoleEvent):void{
			gu.handleFault(event.fault);
		}
	}
}