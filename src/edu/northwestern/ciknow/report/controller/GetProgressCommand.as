package edu.northwestern.ciknow.report.controller
{
	import edu.northwestern.ciknow.common.util.GeneralUtil;

	public class GetProgressCommand
	{
		import edu.northwestern.ciknow.common.events.GeneralEvent;
		import edu.northwestern.ciknow.common.util.LogUtil;
		
		import mx.collections.ArrayCollection;
		import mx.controls.Alert;
		import mx.logging.ILogger;
		import mx.rpc.AsyncToken;
		import mx.rpc.events.FaultEvent;
		import mx.rpc.events.ResultEvent;
		import mx.rpc.remoting.RemoteObject;
		
		private static var logger:ILogger = LogUtil.getLog(GetProgressCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get progress...");
			return service.getProgress(event.data);
		}
		
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			logger.info("Get progress finished... ");
			var result:Object = event.result;
			
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GET_PROGRESS_DONE);
			e.data = ArrayCollection(result);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
		
	}
}