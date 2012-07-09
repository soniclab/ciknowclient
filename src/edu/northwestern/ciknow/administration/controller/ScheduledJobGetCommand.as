package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.events.GeneralEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class ScheduledJobGetCommand
	{
		private static var logger:ILogger = LogUtil.getLog(ScheduledJobGetCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function ScheduledJobGetCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get jobs...");
			return service.getScheduledJobs();
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{
			logger.debug("Got jobs.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GOT_SCHEDULED_JOBS);
			e.data = event.result;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}