package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.events.NodeEvent;
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
	
	public class DeriveAttributesBySurveyProgressCommand
	{
		private static var logger:ILogger = LogUtil.getLog(DeriveAttributesBySurveyProgressCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function DeriveAttributesBySurveyProgressCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("Deriving attributes by survey progress...");
			return service.deriveAttributeByProgress(event.data);
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{		
			logger.info("Derived attributes by survey progress.");
			var n:Number = Number(event.result);
			
			var msg:String;
			if (n <= 0) msg = "No attribute is derived.";
			else msg = "The attribute on " + n + " nodes were derived. Save your work and login again to see new attributes.";
			Alert.show(msg);
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}