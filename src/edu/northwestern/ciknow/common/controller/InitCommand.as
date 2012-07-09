package edu.northwestern.ciknow.common.controller
{
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.GeneralEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import spark.collections.Sort;

	public class InitCommand
	{
		private static const logger:ILogger = LogUtil.getLog(InitCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function InitCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("getting init data from server...");
			return service.init(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{
			logger.info("init data received.");
			
			var data:Object = event.result;
			gu.initApp(data);
			
			// ready to show user interface...
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.INITED);
			dispatcher(e);
			logger.info("got all data.");		
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}