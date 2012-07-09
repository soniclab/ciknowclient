package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.domain.SurveyDTO;
	import edu.northwestern.ciknow.common.events.NodeEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class SurveyGeneratePasswordCommand
	{
		private static var logger:ILogger = LogUtil.getLog(SurveyGeneratePasswordCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var model:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function SurveyGeneratePasswordCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("Generating password ...");
			return service.generatePassword(event.data);
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{
			logger.info("Password generated.");
			var e:NodeEvent = new NodeEvent(NodeEvent.GENERATED_PASSWORD);
			e.data = event.result;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}