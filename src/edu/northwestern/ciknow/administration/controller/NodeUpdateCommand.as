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
	import mx.events.CloseEvent;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class NodeUpdateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodeUpdateCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;
		
		[Inject(id="nodeCache")]
		public var nodeCache:IDataCache;
		
		[Inject]
		public var nodePM:NodePM;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function NodeUpdateCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("Updating node...");
			return service.saveNode(NodeDTO(event.data));
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{
			logger.info("Node updated.");
			var node:NodeDTO = NodeDTO(nodeCache.synchronizeItem(NodeDTO(event.result)));
			node.dirty = false;
			
			// may not be necessary
			dispatcher(new NodeEvent(NodeEvent.LOADED_CURRENT_NODE));
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			var fs:String = event.fault.faultString;
			var msg:String;			
			if (fs.indexOf(GeneralUtil.DATA_INTEGRITY)==0 
				|| fs.indexOf(GeneralUtil.OPTIMISTIC_LOCK)==0){
				msg = "Node is out of sync with server. It is being refreshed.";
				Alert.show(msg, "Error");
				
				nodePM.resetNode();
			} else gu.handleFault(event.fault);
		}
	}
}