package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.EdgeEvent;
	import edu.northwestern.ciknow.common.util.EdgeUtil;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class EdgeDeleteByTypeCommand
	{
		private static var logger:ILogger = LogUtil.getLog(EdgeDeleteByTypeCommand);

		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="edgeRO")]
		public var service:RemoteObject;

		[Inject]
		public var sm:SharedModel;
		
		[Inject]
		public var eu:EdgeUtil;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function EdgeDeleteByTypeCommand()
		{
		}
		
		public function execute(event:EdgeEvent):AsyncToken{			
			var edgeType:String = String(event.data);
			logger.info("Deleting edges by type: " + edgeType);
			return service.deleteEdgesByType(edgeType);			
		}
		
		public function result(event:ResultEvent, trigger:EdgeEvent):void{
			var edgeIds:ArrayCollection = event.result as ArrayCollection;
			var edgeType:String = String(trigger.data);
			
			var eds:ArrayCollection = sm.edgeTypeDescriptions;
			var ed:Object = eu.getEdgeDescription(eds, edgeType);
			eds.removeItemAt(eds.getItemIndex(ed));
			
			dispatcher(new EdgeEvent(EdgeEvent.DELETED_EDGES_BY_TYPE));
			
			Alert.show(edgeIds.length + " edges of type=" + edgeType + " have been deleted.");
		}
		
		public function error(event:FaultEvent, trigger:EdgeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}