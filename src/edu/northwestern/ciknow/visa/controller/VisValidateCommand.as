package edu.northwestern.ciknow.visa.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.common.events.GeneralEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	import edu.northwestern.ciknow.visa.presentation.savedvis.SavedVisualizationPM;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class VisValidateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(VisValidateCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;	

		[Inject]
		public var svPM:SavedVisualizationPM;
		
		[Inject(id="savedVisualizationCache")]
		public var svCache:IDataCache;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function VisValidateCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Validating vis...");
			return service.validateVis(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{		
			logger.info("Validated vis.");
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.VALIDATED_VIS);
			e.data = event.result;
			dispatcher(e);		
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}