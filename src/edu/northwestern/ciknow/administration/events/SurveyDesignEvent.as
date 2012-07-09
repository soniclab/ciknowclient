package edu.northwestern.ciknow.administration.events
{
	import flash.events.Event;
	
	public class SurveyDesignEvent extends Event
	{
		public static const START_CHANGE_QUESTION_ORDER:String = "startChangeQuestionOrder";
		//public static const END_CHANGE_QUESTION_ORDER:String = "endChangeQuestionOrder";
		
		public function SurveyDesignEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}