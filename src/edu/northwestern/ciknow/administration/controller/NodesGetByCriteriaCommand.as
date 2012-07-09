package edu.northwestern.ciknow.administration.controller
{
	import com.adobe.cairngorm.integration.data.DataCache;
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
	
	public class NodesGetByCriteriaCommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodesGetByCriteriaCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var sm:SharedModel;	// shared model
		
		[Inject]
		public var pm:NodePM;		// presentation model
		
		[Inject(id="nodeCache")]
		public var nodeCache:DataCache;

		[Inject]
		public var gu:GeneralUtil;
		
		public function NodesGetByCriteriaCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("Searching nodes by criteria...");
			return service.getNodesByCriteria(event.data);
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{		
			logger.info("Received nodes for page: " + trigger.data.page + " by criteria.");
			var result:Object = event.result;
			
			nodeCache.clear();
			nodeCache.synchronizeItem(sm.loginNode);
			pm.nodes = nodeCache.synchronize(ArrayCollection(result.nodes));
			pm.selectedNode = null;
			pm.selectedNodes = null;
			if (result.hasOwnProperty("count")){
				pm.nodeTotal = Number(result.count);
				var pageNum:int = Math.ceil(pm.nodeTotal/pm.pageSize);
				pm.rangeCount = Math.min(pageNum, 5);
				logger.info("includeCount: true");
				logger.info("total: " + pm.nodeTotal);
				logger.info("rangeCount: " + pm.rangeCount);
			}
			logger.info(pm.nodes.length + " nodes retrieved for this page.");
			
			var e:NodeEvent = new NodeEvent(NodeEvent.GOT_NODES_BY_CRITERIA);
			e.data = result;
			dispatcher(e);						
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}