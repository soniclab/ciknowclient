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

	public class TeamAssemblyGetConfigCommand
	{
		private static var logger:ILogger = LogUtil.getLog(TeamAssemblyGetConfigCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="genericRO")]
		public var service:RemoteObject;

		[Inject]
		public var gu:GeneralUtil;

		
		public function TeamAssemblyGetConfigCommand()
		{
			
		}
		
		public function execute(event:RecommendationEvent):AsyncToken{
			logger.info("Get team assembly config ...");	
			return service.getTeamAssemblyConfig(event.data);
		}
		
		public function result(event:ResultEvent, trigger:RecommendationEvent):void{
			logger.info("Got team assembly config.");			
			var e:RecommendationEvent = new RecommendationEvent(RecommendationEvent.GOT_TEAM_ASSEMBLY_CONFIG);
			e.data = event.result;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:RecommendationEvent):void{
			gu.handleFault(event.fault);
		}
	}
}