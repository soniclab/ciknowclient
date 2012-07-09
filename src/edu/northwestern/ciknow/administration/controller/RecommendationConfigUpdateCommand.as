package edu.northwestern.ciknow.administration.controller
{
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.RecommendationEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import spark.collections.Sort;

	public class RecommendationConfigUpdateCommand
	{
		private static var logger:ILogger = LogUtil.getLog(RecommendationConfigUpdateCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="recommenderService")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;

		public function RecommendationConfigUpdateCommand()
		{
			
		}
		
		public function execute(event:RecommendationEvent):AsyncToken{
			logger.info("Update recommender configuration ...");	
			return service.updateRecConfig(event.data);
		}
		
		public function result(event:ResultEvent, trigger:RecommendationEvent):void{
			logger.info("Updated recommender configuration.");
			dispatcher(new RecommendationEvent(RecommendationEvent.UPDATED_REC_CONFIG));
			Alert.show("Configuration saved.");
		}
		
		public function error(event:FaultEvent, trigger:RecommendationEvent):void{
			gu.handleFault(event.fault);
		}
	}
}