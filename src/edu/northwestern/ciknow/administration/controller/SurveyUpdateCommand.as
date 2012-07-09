package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.domain.SurveyDTO;
	import edu.northwestern.ciknow.common.events.SurveyEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class SurveyUpdateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(SurveyUpdateCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="surveyRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var model:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function SurveyUpdateCommand()
		{
		}
		
		public function execute(event:SurveyEvent):AsyncToken{
			logger.info("Updating preferences...");
			return service.updateSurvey(SurveyDTO(event.data.survey));
		}
		
		public function result(event:ResultEvent, trigger:SurveyEvent):void{
			logger.info("Preferences updated.");
			var survey:SurveyDTO = SurveyDTO(event.result);
			model.currentSurvey = survey;
			Alert.show("Your changes have been saved.");
		}
		
		public function error(event:FaultEvent, trigger:SurveyEvent):void{
			gu.handleFault(event.fault);
		}
	}
}