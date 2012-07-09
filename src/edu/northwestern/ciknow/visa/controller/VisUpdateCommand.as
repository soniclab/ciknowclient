package edu.northwestern.ciknow.visa.controller
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.common.domain.VisualizationDTO;
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
	
	public class VisUpdateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(VisUpdateCommand);
		
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
		
		public function VisUpdateCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{
			logger.info("Updating vis...");
			return service.saveOrUpdateVisualization(event.data);
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{					
			var vis:VisualizationDTO = VisualizationDTO(event.result);
			vis = VisualizationDTO(svCache.synchronizeItem(vis));	
			
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.UPDATED_VIS);
			e.data = vis;
			dispatcher(e);
			
			Alert.show("Saved visualization updated.");
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}