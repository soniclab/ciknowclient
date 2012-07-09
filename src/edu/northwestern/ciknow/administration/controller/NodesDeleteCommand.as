package edu.northwestern.ciknow.administration.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.administration.presentation.node.NodePM;
	import edu.northwestern.ciknow.common.domain.NodeDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.NodeEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class NodesDeleteCommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodesDeleteCommand);

		[Inject(id="nodeRO")]
		public var service:RemoteObject;
		
		[Inject(id="nodeCache")]
		public var nodeCache:IDataCache;
			
		[Inject]
		public var pm:NodePM;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function NodesDeleteCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("Deleting nodes...");
			return service.deleteNodeByIds(event.data.nodeIds);
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{
			Alert.show("Selected Node(s) were deleted successfully.");

			//var nodeIds:ArrayCollection = event.result as ArrayCollection;
			for each (var node:NodeDTO in pm.selectedNodes){
				nodeCache.clearItem(node);
				pm.nodes.removeItemAt(pm.nodes.getItemIndex(node));
			}
			pm.selectedNodes = null;
			pm.selectedNode = null;
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}