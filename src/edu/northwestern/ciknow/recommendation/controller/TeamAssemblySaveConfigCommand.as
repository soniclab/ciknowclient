package edu.northwestern.ciknow.recommendation.controller
{
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

	public class TeamAssemblySaveConfigCommand
	{
		private static var logger:ILogger = LogUtil.getLog(TeamAssemblySaveConfigCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;

		
		public function TeamAssemblySaveConfigCommand()
		{
			
		}
		
		public function execute(event:RecommendationEvent):AsyncToken{
			logger.info("Save team assembly config ...");	
			return service.saveTeamAssemblyConfig(event.data);
		}
		
		public function result(event:ResultEvent, trigger:RecommendationEvent):void{
			logger.info("Saved team assembly config.");			
			var e:RecommendationEvent = new RecommendationEvent(RecommendationEvent.SAVED_TEAM_ASSEMBLY_CONFIG);
			e.data = event.result;
			dispatcher(e);
			
			Alert.show("Team Assembly Configuration Saved.");
		}
		
		public function error(event:FaultEvent, trigger:RecommendationEvent):void{
			gu.handleFault(event.fault);
		}
	}
}