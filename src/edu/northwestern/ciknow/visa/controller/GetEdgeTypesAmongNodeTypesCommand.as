package edu.northwestern.ciknow.visa.controller
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
	
	public class GetEdgeTypesAmongNodeTypesCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GetEdgeTypesAmongNodeTypesCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="edgeRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function GetEdgeTypesAmongNodeTypesCommand()
		{
		}
		
		public function execute(event:EdgeEvent):AsyncToken{
			logger.info("Get edge types among node types...");
			return service.getEdgeTypesAmongNodeTypes(event.data);
		}
		
		public function result(event:ResultEvent, trigger:EdgeEvent):void{		
			logger.info("Got edge types among node types.");
			var e:EdgeEvent = new EdgeEvent(EdgeEvent.GOT_EDGE_TYPES_AMONG_NODE_TYPES);
			e.data = new Object();
			e.data.availableEdgeTypes = ArrayCollection(event.result);
			e.data.source = String(trigger.data.source);
			
			dispatcher(e);					
		}
		
		public function error(event:FaultEvent, trigger:EdgeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}