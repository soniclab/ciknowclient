package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.events.EdgeEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class SaveEdgeTypeDescriptionsCommand
	{
		private static var logger:ILogger = LogUtil.getLog(SaveEdgeTypeDescriptionsCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="edgeRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function SaveEdgeTypeDescriptionsCommand()
		{
		}
		
		public function execute(event:EdgeEvent):AsyncToken{
			logger.info("Save Edge Type Descriptions...");
			return service.saveEdgeTypeDescriptions(event.data);
		}
		
		public function result(event:ResultEvent, trigger:EdgeEvent):void{	
			logger.info("Edge Type Descriptions Saved.");
			var e:EdgeEvent = new EdgeEvent(EdgeEvent.EDGE_TYPE_DESCRIPTIONS_SAVED);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:EdgeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}