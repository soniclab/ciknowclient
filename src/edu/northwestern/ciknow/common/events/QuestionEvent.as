package edu.northwestern.ciknow.common.events
{
	import flash.events.Event;

	public class QuestionEvent extends Event
	{
		// Question.mxml, QuestionPopup.mxml
		public static const SELECTION_CHANGED:String = "questionSelectionChanged";
		public static const CREATE_QUESTION:String='createQuestion';
		public static const COPY_QUESTION:String='copyQuestion';
		public static const UPDATE_QUESTION:String='updateQuestion';
		public static const UPDATE_QUESTIONS:String='updateQuestions';
		public static const UPDATED_QUESTION:String='updatedQuestion';
		public static const UPDATED_QUESTIONS:String='updatedQuestions';
		public static const CLEAR_QUESTION:String='clearQuestion';
		public static const DELETE_QUESTION:String='deleteQuestion';
		public static const REFRESH_QUESTION:String = "refreshQuestion";
		public static const REFRESHED_QUESTION:String = "refreshedQuestion";
		public static const REFRESH_QUESTIONS:String = "refreshQuestions";
		public static const REFRESHED_QUESTIONS:String = "refreshedQuestions";
		
		public static const CURRENT_QUESTION_UPDATED:String = "currentQuestionUpdated";
		
		public static const ADD_FIELD_TO_QUESTION:String = 'addFieldToQuestion';
		public static const ADD_FIELD_TO_QUESTION_DONE:String = 'addFieldToQuestionDone';
		public static const ADD_TEXT_FIELD_TO_QUESTION:String = 'addTextFieldToQuestion';
		public static const ADD_TEXT_FIELD_TO_QUESTION_DONE:String = 'addTextFieldToQuestionDone';
		public static const ADD_CONTACT_FIELD_TO_QUESTION:String = 'addContactFieldToQuestion';
		public static const ADD_CONTACT_FIELD_TO_QUESTION_DONE:String = 'addContactFieldToQuestionDone';
				
		public static const CHANGE_QUESTION_ORDER:String = "changeQuestionOrder";
		public static const CHANGED_QUESTION_ORDER:String = "changedQuestionOrder";
		
		public static const GET_CHART_DATA:String = "getChartData";
		public static const GOT_CHART_DATA:String = "gotChartData";
		
		public static const GET_QUESTION_DATA:String = "getQuestionData";
		public static const GOT_QUESTION_DATA:String = "gotQuestionData";
		
		// in relational questions which has an affiliated contact chooser 
		public static const JUMP_TO_CONTACT_CHOOSER:String = "jumpToContactChooser"; 
		public static const JUMP_TO_QUESTION:String = "jumpToQuestion";
		
		// save question data
		public static const SAVE_TEXT_QUICK:String = "saveQuestionTextQuick";
		
		
		public var data:Object = new Object();
		
		public function QuestionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new QuestionEvent(type, bubbles, cancelable);
		}
	}

}