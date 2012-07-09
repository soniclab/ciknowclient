package edu.northwestern.ciknow.administration.controller
{
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

	public class SaveNodeTypeDescriptionsCommand
	{
		private static var logger:ILogger = LogUtil.getLog(SaveNodeTypeDescriptionsCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function SaveNodeTypeDescriptionsCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("Save Node Type Descriptions...");
			return service.saveNodeTypeDescriptions(event.data);
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{	
			logger.info("Node Type Descriptions Saved.");
			var e:NodeEvent = new NodeEvent(NodeEvent.NODE_TYPE_DESCRIPTIONS_SAVED);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}