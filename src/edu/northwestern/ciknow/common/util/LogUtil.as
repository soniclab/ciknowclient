package edu.northwestern.ciknow.common.util
{
	import flash.utils.*;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.TraceTarget;
	
	public class LogUtil
	{
		public function LogUtil()
		{
		}
		
		public static function confLog():void{					
			var _target:TraceTarget = new TraceTarget( );
			_target.includeDate = true;
			_target.includeTime = true;
			_target.includeLevel = true;
			_target.includeCategory = true;
			_target.level = LogEventLevel.DEBUG;
			_target.filters = [
				"edu.northwestern.ciknow.common.app.*", 
				"edu.northwestern.ciknow.common.util.*",
				"edu.northwestern.ciknow.app.presentation.*"]; 
			Log.addTarget(_target);
		}
		
		public static function getLog(value:Object):ILogger
		{
			var name:String;
			if (value is Class) name = getQualifiedClassName(value).replace("::", ".");
			else name = value.toString();
			return Log.getLogger(name);
		}
	}
}