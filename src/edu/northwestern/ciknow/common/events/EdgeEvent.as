package edu.northwestern.ciknow.common.events
{

	import flash.events.Event;

	public class EdgeEvent extends Event
	{
		public static const SAVE_QUESTION_EDGE:String = "saveQuestionEdge"; // create or update
		public static const SAVED_QUESTION_EDGE:String = "savedQuestionEdge";
		public static const DELETE_QUESTION_EDGE:String = "deleteQuestionEdge";
		public static const DELETED_QUESTION_EDGE:String = "deletedQuestionEdge";
		
		// edge manager
		//public static const EDGE_TYPE_DESCRIPTIONS_READY:String = 'edgeTypeDescriptionReady';
		public static const SAVE_EDGE_TYPE_DESCRIPTIONS:String = 'saveEdgeTypeDescription';
		public static const EDGE_TYPE_DESCRIPTIONS_SAVED:String = 'edgeTypeDescriptionSaved';		
		public static const DERIVE_EDGES_BY_RELATION:String = "deriveEdgesByRelation";
		public static const DERIVE_EDGES_BY_ATTRIBUTE:String = "deriveEdgesByAttribute";
		public static const DERIVE_EDGES_BY_CC:String = "deriveEdgesByCC";
		public static const EDGES_DERIVED:String = "edgesDerived";
		public static const UPDATE_EDGE_WEIGHTS:String = "updateEdgeWeights";
		public static const DELETE_EDGES_BY_TYPE:String = "deleteEdgesByType";
		public static const DELETED_EDGES_BY_TYPE:String = "deletedEdgesByType";
		public static const SYMMETRIZE_EDGE:String = "symmetrizeEdge";
		
		// edges in node manager
		public static const GET_CURRENT_USER_OUTGOING_EDGES:String = "getCurrentUserOutgoingEdges";
		public static const CURRENT_USER_OUTGOING_EDGES_READY:String = "getCurrentUserOutgoingEdgesReady";
		public static const GET_CURRENT_USER_INCOMING_EDGES:String = "getCurrentUserIncomingEdges";
		public static const CURRENT_USER_INCOMING_EDGES_READY:String = "getCurrentUserIncomingEdgesReady";

		// taggings in node manager
		public static const TAG_CURRENT_USER:String = "TagCurrentUser";
		public static const TAG_CURRENT_USER_DONE:String = "TagCurrentUserDone";				
		public static const UNTAG_CURRENT_USER_BY_TAG:String = "UntagCurrentUserByTag";
		public static const UNTAG_CURRENT_USER_BY_TAG_DONE:String = "UntagCurrentUserByTagDone";
		
		// DerivationManager.mxml
		public static const GET_EDGE_TYPES_BY_NODE_TYPES:String = "getEdgeTypesByNodeTypes";
		public static const GOT_EDGE_TYPES_BY_NODE_TYPES:String = "gotEdgeTypesByNodeTypes";
		
		// visualanalytics
		public static const GET_EDGE_TYPES_AMONG_NODE_TYPES:String = "getEdgeTypesAmongNodeTypes";
		public static const GOT_EDGE_TYPES_AMONG_NODE_TYPES:String = "gotEdgeTypesAmongNodeTypes";		
				
		// recommendation config
		public static const GET_EDGE_TYPES_BY_FROM_TO_NODE_TYPES:String = "getEdgeTypesByFromToNodes";
		public static const GOT_EDGE_TYPES_BY_FROM_TO_NODE_TYPES:String = "gotEdgeTypesByFromToNodes";
				
		public var data:Object = new Object();
		
		public function EdgeEvent (type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			
			super(type, bubbles, cancelable);
			
		}
		
		override public function clone():Event{
		
			return new EdgeEvent(type, bubbles, cancelable);
			
		}

		
	}

}