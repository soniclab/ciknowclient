package edu.northwestern.ciknow.common.events
{
	import flash.events.Event;

	public class NodeEvent extends Event
	{
		// QuestionBase.mxml
		public static const SAVE_QUESTION_NODE:String = "saveQuestionNode";			
		public static const SAVED_QUESTION_NODE:String = "savedQuestionNode";
				
		// PasswordManager.mxml
 		public static const UPDATE_PASSWORD:String='updatePassword';
		public static const UPDATED_PASSWORD:String='updatedPassword'; 

		// Survey.mxml
		public static const GENERATE_PASSWORD:String = "generatePassword";
		public static const GENERATED_PASSWORD:String = "generatedPassword";
		
		// EgoNetwork.mxml, NodeReport.mxml, PullRecommender.mxml
		public static const GET_PLAIN_NODES:String="getPlainNodes";
		public static const GOT_PLAIN_NODES:String="gotPlainNodes";
		
		// NodePM.as
		public static const GET_NODES_BY_CRITERIA:String = "getNodesByCriteria";
		public static const GOT_NODES_BY_CRITERIA:String = "gotNodesByCriteria";
		//public static const SEARCH_NODE:String = "searchNode";
		//public static const SELECT_NODE:String = "selectNode";
		
		public static const LOAD_CURRENT_NODE:String = "loadCurrentNode";
		public static const LOADED_CURRENT_NODE:String = "loadedCurrentNode";
		
		public static const CHECK_USERNAME_AVAILABILITY:String = "checkUsernameAvailability";
		public static const UPDATE_NODE:String='updateNode';
		public static const CREATE_NODE:String='createNode';
		public static const CREATED_NODE:String='createdNode';
		public static const DELETE_NODES:String='deleteNodes';
		public static const DELETED_NODES:String='deletedNodes';		
/*		public static const SAVE_NODES:String='saveNodes';
		public static const SAVED_NODES:String='savedNodes';*/
		public static const CLEAR_DATA:String='clearData';
		public static const CLEARED_DATA:String='clearedData';		
		
		// Survey.mxml
		public static const APPLY_LOGIN_MODE:String = "applyLoginMode";
		
		// DerivationManager.mxml
		public static const DERIVE_BY_PRODUCT:String = "DeriveByProduct";
		public static const DERIVED_BY_PRODUCT:String = "DerivedByProduct";
		public static const DERIVE_BY_ANALYTICS:String = "DeriveByAnalytics";
		public static const DERIVED_BY_ANALYTICS:String = "DerivedByAnalytics";
		public static const DERIVE_BY_EQUATION:String = "DeriveByEquation";
		public static const DERIVED_BY_EQUATION:String = "DerivedByEquation";
		public static const DERIVE_BY_SOCIAL_INFLUENCE:String = "DeriveByInfluence";
		public static const DERIVED_BY_SOCIAL_INFLUENCE:String = "DerivedByInfluence";
		public static const CHECK_ATTR_NAME_AVAILABILITY:String = "CheckAttrNameAvailability";
		public static const CHECKED_ATTR_NAME_AVAILABILITY:String = "CheckedAttrNameAvailability";
		public static const DELETE_ATTRIBUTE_BY_NAME:String = "DeleteAttrByName";
		public static const DERIVE_BY_PROGRESS:String = "DeriveByProgress";
		
		// temperarily in EdgeManager2.mxml
		public static const SAVE_NODE_TYPE_DESCRIPTIONS:String = 'saveNodeTypeDescription';
		public static const NODE_TYPE_DESCRIPTIONS_SAVED:String = 'nodeTypeDescriptionSaved';		
		
		// contact chooser.mxml
		public static const GET_CC_LEVEL_ATTRIBUTES:String = "getCCLevelAttributes";
		public static const GOT_CC_LEVEL_ATTRIBUTES:String = "gotCCLevelAttributes";
			
		public var data:Object = new Object();
		
		public function NodeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new NodeEvent(type, bubbles, cancelable);
		}
	}

}