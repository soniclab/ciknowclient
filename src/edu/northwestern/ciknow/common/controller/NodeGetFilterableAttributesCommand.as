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
	
	public class NodeGetFilterableAttributesCommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodeGetFilterableAttributesCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function NodeGetFilterableAttributesCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get filterable attributes...");
			return service.getFilterableAttributes(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			logger.info("Got filterable attributes.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GOT_FILTER_ATTRIBUTES);
			e.data = ArrayCollection(event.result);
			dispatcher(e);					
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}