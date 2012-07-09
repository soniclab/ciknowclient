package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.events.EdgeEvent;
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
	
	public class DeriveEdgesByRelationCommand
	{
		private static var logger:ILogger = LogUtil.getLog(DeriveEdgesByRelationCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="edgeRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function DeriveEdgesByRelationCommand()
		{
		}
		
		public function execute(event:EdgeEvent):AsyncToken{
			logger.info("Deriving edges by relation...");
			return service.deriveEdgesByRelation(event.data);
		}
		
		public function result(event:ResultEvent, trigger:EdgeEvent):void{		
			logger.info("Derived edges by relation.");
			var n:Number = Number(event.result);
			var msg:String;
			if (n == 0) msg = "No edges were derived. No corresponding edge type was created, of course.";
			else msg = n + " edges were derived. Save your work and login again to see new edges.";
			Alert.show(msg);
			
			dispatcher(new QuestionEvent(QuestionEvent.REFRESH_QUESTIONS));				
		}
		
		public function error(event:FaultEvent, trigger:EdgeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}