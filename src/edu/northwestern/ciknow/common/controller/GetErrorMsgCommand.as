package edu.northwestern.ciknow.common.controller
{
	import edu.northwestern.ciknow.common.events.GeneralEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class GetErrorMsgCommand
	{
		private static const logger:ILogger = LogUtil.getLog(GetErrorMsgCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function GetErrorMsgCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Get error message from server for nodeId=" + event.data + "...");
			return service.getErrorMsg(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{
			logger.info("Got error message.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GOT_ERROR_MSG);
			e.data = String(event.result);
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}