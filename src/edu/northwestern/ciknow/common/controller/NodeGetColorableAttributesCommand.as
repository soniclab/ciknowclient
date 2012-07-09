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
	
	public class NodeGetColorableAttributesCommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodeGetColorableAttributesCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function NodeGetColorableAttributesCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get colorable attributes...");
			return service.getColorableAttributes(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			logger.info("Got colorable attributes.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GOT_COLOR_ATTRIBUTES);
			e.data = new Object();
			e.data.attributes = ArrayCollection(event.result);
			e.data.source = trigger.data.source;
			dispatcher(e);					
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}