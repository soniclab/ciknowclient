package edu.northwestern.ciknow.common.events
{
	import flash.events.Event;

	public class CustomUIEvent extends Event
	{
		// Dispatch when custom UI component finishes data population
		public static const POPULATED:String = "populated";
		
		public var data:Object = new Object();
		
		public function CustomUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new CustomUIEvent(type, bubbles, cancelable);
		}
	}

}