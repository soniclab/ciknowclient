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

	public class GroupUpdateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GroupUpdateCommand);
		
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
		
		public function GroupUpdateCommand()
		{
		}
		
		public function execute(event:GroupEvent):AsyncToken{
			logger.info("Updating group...");
			return service.updateGroup(GroupDTO(event.data));
		}
		
		public function result(event:ResultEvent, trigger:GroupEvent):void{
			var group:GroupDTO = GroupDTO(event.result);
			logger.debug("Group (" + group.name + ") is updated successfully.");
			
			group = GroupDTO(groupCache.synchronizeItem(group));
			
			var e:GroupEvent = new GroupEvent(GroupEvent.UPDATE_GROUP_DONE);
			e.data = group;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:GroupEvent):void{
			gu.handleFault(event.fault);
		}
	}
}