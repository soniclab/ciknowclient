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

	public class TeamAssemblyGetSuggestionCommand
	{
		private static var logger:ILogger = LogUtil.getLog(TeamAssemblyGetSuggestionCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;

		
		public function TeamAssemblyGetSuggestionCommand()
		{
			
		}
		
		public function execute(event:RecommendationEvent):AsyncToken{
			logger.info("Get suggestion ...");	
			return service.getTeamAssemblySuggestion(event.data);
		}
		
		public function result(event:ResultEvent, trigger:RecommendationEvent):void{
			logger.info("Got suggestion.");			
			var e:RecommendationEvent = new RecommendationEvent(RecommendationEvent.GOT_TEAM_ASSEMBLY_SUGGESTION);
			e.data = event.result;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:RecommendationEvent):void{
			gu.handleFault(event.fault);
		}
	}
}