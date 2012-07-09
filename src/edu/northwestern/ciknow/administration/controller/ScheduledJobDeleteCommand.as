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

	public class ScheduledJobDeleteCommand
	{
		private static var logger:ILogger = LogUtil.getLog(ScheduledJobDeleteCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function ScheduledJobDeleteCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Delete job...");
			return service.deleteScheduledJob(String(event.data));
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{
			Alert.show("Scheduled job deleted.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.DELETED_SCHEDULED_JOB);
			e.data = trigger.data;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}