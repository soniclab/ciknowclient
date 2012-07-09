package edu.northwestern.ciknow.common.events
{
	import flash.events.Event;

	public class NetworkAnalyticsEvent extends Event
	{ 	
		public static const GET_NETWORK_METRICS:String = "getNetworkMetrics";
		public static const GOT_NETWORK_METRICS:String = "gotNetworkMetrics";	 
					
		public var data:Object = new Object();
		
		public function NetworkAnalyticsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new NetworkAnalyticsEvent(type, bubbles, cancelable);
		}
	}

}