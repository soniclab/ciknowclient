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

	public class NodeLoadCommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodeLoadCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;

		[Inject]
		public var pm:NodePM;
		
		[Inject(id="nodeCache")]
		public var nodeCache:IDataCache;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function NodeLoadCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			var nodeId:String = event.data.nodeId;
			logger.info("Load current node(id=" + nodeId + ")...");
			return service.loadCurrentNode(nodeId);
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{	
			logger.info("Loaded current node.");
			var result:Object = event.result;
			var dto:NodeDTO = NodeDTO(result.node);
			pm.selectedNode = NodeDTO(nodeCache.synchronizeItem(dto));
			pm.incomingEdges = ArrayCollection(result.incomingEdges);
			pm.outgoingEdges = ArrayCollection(result.outgoingEdges);	
			pm.extraNodes = ArrayCollection(result.extraNodes);
			var e:NodeEvent = new NodeEvent(NodeEvent.LOADED_CURRENT_NODE);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}