package edu.northwestern.ciknow.common.events
{
	import flash.events.Event;
	
	public class GmapEvent extends Event
	{
		public static const GET_LOCAL:String = "getLocal";
		public static const LOCAL_READY:String = "localReady";
		public static const GET_CUSTOM:String = "getCustom";
		public static const CUSTOM_READY:String = "customReady";
		
		public var data:Object = new Object();
		
		public function GmapEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new GmapEvent(type, bubbles, cancelable);
		}
	}
}