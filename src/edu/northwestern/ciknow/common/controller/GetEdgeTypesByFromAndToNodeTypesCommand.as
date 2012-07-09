package edu.northwestern.ciknow.common.controller
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
	
	public class GetEdgeTypesByFromAndToNodeTypesCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GetEdgeTypesByFromAndToNodeTypesCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="edgeRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function GetEdgeTypesByFromAndToNodeTypesCommand()
		{
		}
		
		public function execute(event:EdgeEvent):AsyncToken{
			logger.info("Get edge types by from and to node types...");
			return service.getEdgeTypesByFromAndToNodeTypes(event.data);
		}
		
		public function result(event:ResultEvent, trigger:EdgeEvent):void{		
			logger.info("Got edge types by from and to node types.");
			var e:EdgeEvent = new EdgeEvent(EdgeEvent.GOT_EDGE_TYPES_BY_FROM_TO_NODE_TYPES);
			e.data = ArrayCollection(event.result);			
			dispatcher(e);					
		}
		
		public function error(event:FaultEvent, trigger:EdgeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}