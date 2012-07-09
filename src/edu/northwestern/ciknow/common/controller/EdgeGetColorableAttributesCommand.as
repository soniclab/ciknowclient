package edu.northwestern.ciknow.common.controller
{
	import edu.northwestern.ciknow.common.events.GeneralEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class EdgeGetColorableAttributesCommand
	{
		private static var logger:ILogger = LogUtil.getLog(EdgeGetColorableAttributesCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function EdgeGetColorableAttributesCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get edge colorable attributes...");
			return service.getEdgeColorableAttributes();
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			logger.info("Got edge colorable attributes.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GOT_EDGE_COLOR_ATTRIBUTES);
			e.data = ArrayCollection(event.result);
			dispatcher(e);					
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}