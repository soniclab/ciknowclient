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

	public class GroupGetPlainNodesCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GroupGetPlainNodesCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="groupRO")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;
		
		public function GroupGetPlainNodesCommand()
		{
		}
		
		public function execute(event:GroupEvent):AsyncToken{
			var groupId:String = String(event.data.groupId);
			logger.info("Get plain nodes by groupId: " + groupId);
			return service.getPlainNodesByGroupId(groupId);
		}
		
		public function result(event:ResultEvent, trigger:GroupEvent):void{	
			logger.info("Got plain nodes by groupId.");
			var nodes:ArrayCollection = ArrayCollection(event.result);
			nodes.sort = gu.getSort("label");
			nodes.refresh();
			
			var e:GroupEvent = new GroupEvent(GroupEvent.GOT_PLAIN_NODES_BY_GROUP_ID);
			e.data = new Object();
			e.data.nodes = nodes;
			e.data.groupId = String(trigger.data.groupId);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:GroupEvent):void{
			gu.handleFault(event.fault);
		}
	}
}