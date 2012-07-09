package edu.northwestern.ciknow.common.events
{

	import flash.events.Event;

	public class SurveyEvent extends Event
	{
		// Survey.mxml, GmapAdmin.mxml
		public static const UPDATE_SURVEY:String='updateSurvey';

		public static const CURRENT_SURVEY_UPDATED:String='currentSurveyUpdated';

		public var data:Object = new Object();
		
		public function SurveyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new SurveyEvent(type, bubbles, cancelable);
		}
	}

}