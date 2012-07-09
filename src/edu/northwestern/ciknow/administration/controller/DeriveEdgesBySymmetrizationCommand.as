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
	
	public class DeriveEdgesBySymmetrizationCommand
	{
		private static var logger:ILogger = LogUtil.getLog(DeriveEdgesBySymmetrizationCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="edgeRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function DeriveEdgesBySymmetrizationCommand()
		{
		}
		
		public function execute(event:EdgeEvent):AsyncToken{
			logger.info("Deriving edges by symmetrization...");
			return service.deriveEdgesBySymmetrization(event.data);
		}
		
		public function result(event:ResultEvent, trigger:EdgeEvent):void{		
			logger.info("Derived edges by symmetrization.");
			var edgeCount:Number = Number(event.result.edgeCount);
			var edgeType:String = String(event.result.edgeType);
			
			var msg:String = "";
			msg = edgeCount + " edges (type=" + edgeType + ") were created.";
			Alert.show(msg);
			
			dispatcher(new QuestionEvent(QuestionEvent.REFRESH_QUESTIONS));				
		}
		
		public function error(event:FaultEvent, trigger:EdgeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}