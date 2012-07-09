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

	public class CheckNodeAttributeAvailabilityCommand
	{
		private static var logger:ILogger = LogUtil.getLog(CheckNodeAttributeAvailabilityCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;
		
		public function CheckNodeAttributeAvailabilityCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			var attrName:String = String(event.data);
			logger.debug("Checking availability of node attribute: " + attrName);
			return service.isAttrNameAvailable(attrName);
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{	
			var e:NodeEvent = new NodeEvent(NodeEvent.CHECKED_ATTR_NAME_AVAILABILITY);
			e.data = new Object();
			e.data.n = event.result;
			e.data.attrName = String(trigger.data);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}