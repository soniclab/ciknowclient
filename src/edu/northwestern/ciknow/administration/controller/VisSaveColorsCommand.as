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
	
	public class VisSaveColorsCommand
	{
		private static var logger:ILogger = LogUtil.getLog(VisSaveColorsCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var gu:GeneralUtil;
		
		public function VisSaveColorsCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Save vis colors...");
			return service.saveVisColors(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			Alert.show("Visualization Colors are saved.", "NOTE");					
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}