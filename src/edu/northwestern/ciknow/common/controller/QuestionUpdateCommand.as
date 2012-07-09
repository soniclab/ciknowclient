package edu.northwestern.ciknow.common.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.common.domain.QuestionDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.QuestionEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import spark.collections.Sort;

	public class QuestionUpdateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(QuestionUpdateCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="questionRO")]
		public var service:RemoteObject;
		
		[Inject(id="questionCache")]
		public var questionCache:IDataCache;
		
		[Inject]
		public var gu:GeneralUtil;
		
		private var updateQuestion:QuestionDTO;
		
		public function QuestionUpdateCommand()
		{
		}
		
		public function execute(event:QuestionEvent):AsyncToken{
			logger.info("Updating question...");
			updateQuestion = QuestionDTO(event.data);
			return service.updateQuestion(updateQuestion);
		}
		
		public function result(event:ResultEvent, trigger:QuestionEvent):void{
			logger.info("Question updated.");
			var question:QuestionDTO = QuestionDTO(questionCache.synchronizeItem(QuestionDTO(event.result)));
			
			var e:QuestionEvent = new QuestionEvent(QuestionEvent.UPDATED_QUESTION);
			e.data = question;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:QuestionEvent):void{
			var fs:String = event.fault.faultString;
			var msg:String;			
			if (fs.indexOf(GeneralUtil.DATA_INTEGRITY)==0 
				|| fs.indexOf(GeneralUtil.OPTIMISTIC_LOCK)==0){
				msg = "Question is out of sync with server. It is being refreshed.";
				Alert.show(msg, "Error");
				
				var e:QuestionEvent = new QuestionEvent(QuestionEvent.REFRESH_QUESTION);
				e.data = updateQuestion.questionId.toString();
				dispatcher(e);
			} else gu.handleFault(event.fault);
		}
	}
}