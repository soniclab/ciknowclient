package edu.northwestern.ciknow.administration.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.administration.presentation.node.NodesClearPopup;
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

	public class NodesClearDataCommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodesClearDataCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;
		
		[Inject(id="nodeCache")]
		public var nodeCache:IDataCache;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function NodesClearDataCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("Clearing node(s) data...");
			return service.clearDataByIds(ArrayCollection(event.data.nodeIds), String(event.data.type));
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{	
			logger.info("Node(s) data cleared.");
			nodeCache.synchronize(ArrayCollection(event.result));
			
			var e:NodeEvent = new NodeEvent(NodeEvent.LOADED_CURRENT_NODE);
			dispatcher(e);
			
			var msg:String = "";
			var type:String = String(trigger.data.type);
			if (type == NodesClearPopup.ALL_BUT_CONTACTS) msg += "All data (except contacts) of selected nodes have been cleared.";
			else if (type == NodesClearPopup.CONTACTS) msg += "Contacts of selected nodes have been cleared.";
			else if (type == NodesClearPopup.TRACES) msg += "Traces of selected nodes have been cleared.";
			Alert.show(msg);
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}