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
	
	public class VisDeleteCommand
	{
		private static var logger:ILogger = LogUtil.getLog(VisDeleteCommand);
		
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
		
		public function VisDeleteCommand()
		{
		}
		
		public function execute(event:GeneralEvent):AsyncToken{			
			var vis:VisualizationDTO = VisualizationDTO(event.data.vis);
			logger.info("Deleting vis: id=" + vis.visId);
			return service.deleteVisualization(vis.visId.toString());
		}
		
		public function result(event:ResultEvent, trigger:GeneralEvent):void{					
			var vis:VisualizationDTO = VisualizationDTO(trigger.data.vis);
			svCache.clearItem(vis);
			svPM.createdViss.removeItemAt(svPM.createdViss.getItemIndex(vis));
			logger.info("Deleted vis.");
		}
		
		public function error(event:FaultEvent, trigger:GeneralEvent):void{
			gu.handleFault(event.fault);
		}
	}
}