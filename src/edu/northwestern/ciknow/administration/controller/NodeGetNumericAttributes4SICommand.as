package edu.northwestern.ciknow.administration.controller
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
	
	public class NodeGetNumericAttributes4SICommand
	{
		private static var logger:ILogger = LogUtil.getLog(NodeGetNumericAttributes4SICommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function NodeGetNumericAttributes4SICommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get numeric attributes for social influence...");
			return service.getNumericAttributesForSocialInference(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			logger.info("Got numeric attributes for social influence.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GOT_NUMERIC_ATTRIBUTES_FOR_SOCIAL_INFERENCE);
			e.data = ArrayCollection(event.result);
			dispatcher(e);					
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}