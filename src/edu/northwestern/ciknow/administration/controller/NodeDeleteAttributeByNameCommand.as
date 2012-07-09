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

	public class NodeDeleteAttributeByNameCommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodeDeleteAttributeByNameCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;
		
		public function NodeDeleteAttributeByNameCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			var attrName:String = String(event.data);
			logger.debug("Delete node attribute: " + attrName);
			return service.deleteAttributeByName(attrName);
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{	
			Alert.show("Attribute '" + String(trigger.data) + "' is deleted from all nodes.");
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}