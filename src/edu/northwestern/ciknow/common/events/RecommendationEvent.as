package edu.northwestern.ciknow.common.events
{
	
	import flash.events.Event;

	public class RecommendationEvent extends Event
	{
		// PullRecommender.mxml
		public static const GET_RECOMMENDATIONS:String='getRecommendations';
		public static const GOT_RECOMMENDATIONS:String = "gotRecommendations";		
		
		// Recommender.mxml
		public static const GET_REC_CONFIG:String = "getRecConfig";
		public static const GOT_REC_CONFIG:String = "gotRecConfig";
		public static const UPDATE_REC_CONFIG:String = "updateRecConfig";
		public static const UPDATED_REC_CONFIG:String = "updatedRecConfig";
		public static const COMPUTE_RECOMMENDATIONS:String = "computeRecommendations";
		public static const COMPUTED_RECOMMENDATIONS:String = "computedRecommendations";

		// TeamAssembly.mxml
		public static const GET_TEAM_ASSEMBLY_SUGGESTION:String = "getTeamAssemblySuggestion";
		public static const GOT_TEAM_ASSEMBLY_SUGGESTION:String = "gotTeamAssemblySuggestion";
		public static const GET_TEAM_ASSEMBLY_CONFIG:String = "getTeamAssemblyConfig";
		public static const GOT_TEAM_ASSEMBLY_CONFIG:String = "gotTeamAssemblyConfig";
		public static const SAVE_TEAM_ASSEMBLY_CONFIG:String = "saveTeamAssemblyConfig";
		public static const SAVED_TEAM_ASSEMBLY_CONFIG:String = "savedTeamAssemblyConfig";
		public static const ASSEMBLE_TEAM:String = "assembleTeam";
		public static const ASSEMBLED_TEAM:String = "assembledTeam";
		public static const SAVE_TEAMS_4_VIS:String = "saveTeam4Vis";
		public static const SAVED_TEAMS_4_VIS:String = "savedTeam4Vis";		
		
		// Mahout.mxml
		public static const GENERATE_MAHOUT_PREFERENCES:String = "generateMahoutPreferences";
		public static const GENERATED_MAHOUT_PREFERENCES:String = "generatedMahoutPreferences";
		
		public static const GET_MAHOUT_CONFIG:String = "getMahoutConfig";
		public static const GOT_MAHOUT_CONFIG:String = "gotMahoutConfig";
		public static const SAVE_MAHOUT_CONFIG:String = "saveMahoutConfig";
		public static const SAVED_MAHOUT_CONFIG:String = "savedMahoutConfig";
		public static const EVALUATE_MAHOUT_RECOMMENDER:String = "evaluateMahoutRecommender";
		public static const EVALUATED_MAHOUT_RECOMMENDER:String = "evaluatedMahoutRecommender";
		public static const UPDATE_MAHOUT_RECOMMENDER:String = "updateMahoutRecommender";
		public static const UPDATED_MAHOUT_RECOMMENDER:String = "updatedMahoutRecommender";
		
		public static const GET_MAHOUT_RECOMMENDATIONS:String = "getMahoutRecommendations";
		public static const GOT_MAHOUT_RECOMMENDATIONS:String = "gotMahoutRecommendations";
		
		
		public var data:Object = new Object();
		
		public function RecommendationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new RecommendationEvent(type, bubbles, cancelable);
		}
	}

}