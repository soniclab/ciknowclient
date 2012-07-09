package edu.northwestern.ciknow.administration.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.common.domain.GroupDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.GroupEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.GroupUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class GroupDeleteCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GroupDeleteCommand);
		
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
		
		public function GroupDeleteCommand()
		{
		}
		
		public function execute(event:GroupEvent):AsyncToken{
			logger.info("Deleting group...");
			return service.deleteGroupById(GroupDTO(event.data).groupId);
		}
		
		public function result(event:ResultEvent, trigger:GroupEvent):void{
			var groupId:Number = Number(event.result);
			var group:GroupDTO = GroupDTO(trigger.data);			
			logger.debug("Group (" + group.name + ") is deleted successfully.");
			
			groupCache.clearItem(group);
			sm.groups.removeItemAt(sm.groups.getItemIndex(group));

			var index:Number = sm.loginNode.groups.getItemIndex(groupId);
			if (index >= 0){
				logger.debug("loginNode is removed from deleted group.");
				sm.loginNode.groups.removeItemAt(index);
				sm.loginNode.version += 1;
			}
							
			var e:GroupEvent = new GroupEvent(GroupEvent.DELETE_GROUP_DONE);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:GroupEvent):void{
			gu.handleFault(event.fault);
		}
	}
}