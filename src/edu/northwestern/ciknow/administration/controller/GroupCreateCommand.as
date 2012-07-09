package edu.northwestern.ciknow.administration.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.common.domain.GroupDTO;
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

	public class GroupCreateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GroupCreateCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="groupRO")]
		public var service:RemoteObject;
		
		[Inject(id="groupCache")]
		public var groupCache:IDataCache;
		
		[Inject]
		public var sm:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function GroupCreateCommand()
		{
		}
		
		public function execute(event:GroupEvent):AsyncToken{
			logger.info("Creating group...");
			return service.createGroup(GroupDTO(event.data));
		}
		
		public function result(event:ResultEvent, trigger:GroupEvent):void{
			var group:GroupDTO = GroupDTO(event.result);
			logger.debug("New Group (" + group.name + ") is created successfully.");
			
			group = GroupDTO(groupCache.synchronizeItem(group));
			sm.groups.addItem(group);
			
			var e:GroupEvent = new GroupEvent(GroupEvent.CREATE_GROUP_DONE);
			e.data = group;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:GroupEvent):void{
			gu.handleFault(event.fault);
		}
	}
}