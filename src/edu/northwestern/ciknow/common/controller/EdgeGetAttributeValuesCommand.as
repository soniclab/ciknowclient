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
	
	public class EdgeGetAttributeValuesCommand
	{
		private static var logger:ILogger = LogUtil.getLog(EdgeGetAttributeValuesCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function EdgeGetAttributeValuesCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get edge attribute values...");
			var name:String = String(event.data.name);
			return service.getEdgeAttributeValues(name);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			logger.info("Got edge attribute values.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GOT_EDGE_ATTRIBUTE_VALUES);
			e.data = new Object();
			e.data.values = ArrayCollection(event.result);
			e.data.source = String(trigger.data.source);
			dispatcher(e);					
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}