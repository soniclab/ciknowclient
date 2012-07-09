package edu.northwestern.ciknow.common.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
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

	public class NodeCreateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodeCreateCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function NodeCreateCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("Creating node...");
			return service.saveNode(NodeDTO(event.data));
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{
			var node:NodeDTO = NodeDTO(event.result);
			Alert.show("New Node (" + node.label + ") is created successfully.");

			/* for weird reason, the dispatched event failed			
			node = NodeDTO(nodeCache.synchronizeItem(node));
			node.dirty = false;
			pm.nodes = new ArrayCollection();
			pm.nodes.addItem(node);
			pm.selectedNode = node;
			dispatcher(new NodeEvent(NodeEvent.LOADED_CURRENT_NODE));
			*/
			
			var e:NodeEvent = new NodeEvent(NodeEvent.CREATED_NODE);
			e.data = node;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}