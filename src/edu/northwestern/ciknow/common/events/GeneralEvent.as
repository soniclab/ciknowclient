package edu.northwestern.ciknow.common.events
{
	import flash.events.Event;
	
	public class GeneralEvent extends Event
	{
		// index.mxml
		public static const INIT:String = "init";
		public static const INITED:String = "inited";
		
		// resize
		public static const RESIZE:String = "RESIZE";
		
		// FileDownlad.as, FileUpload.as, TextDisplayPopup.as
		public static const POPULATE_TEXT_DISPLAY_POPUP:String = "popuplateTextDisplayPopup";		
		public static const GET_ERROR_MSG:String = "getErrorMsg";
		public static const GOT_ERROR_MSG:String = "gotErrorMsg";
		public static const FILE_UPLOADED:String = "fileUploaded";
		public static const FILE_DOWNLOADED:String = "fileDownloaded";
		
		public static const GET_DISPLAY_ATTRIBUTES:String = "getDisplayAttributes";
		public static const GOT_DISPLAY_ATTRIBUTES:String = "gotDisplayAttributes";
		
		public static const GET_COLOR_ATTRIBUTES:String = "getColorAttributes";
		public static const GOT_COLOR_ATTRIBUTES:String = "gotColorAttributes";
		
		public static const GET_COLOR_ATTRIBUTES_BY_EDGE_TYPES:String = "getColorAttributesByEdgeTypes";
		public static const GOT_COLOR_ATTRIBUTES_BY_EDGE_TYPES:String = "gotColorAttributesByEdgeTypes";
		
		public static const GET_NUMERIC_ATTRIBUTES:String = "getNumericAttributes";
		public static const GOT_NUMERIC_ATTRIBUTES:String = "gotNumericAttributes";
		
		public static const GET_NUMERIC_ATTRIBUTES_FOR_SOCIAL_INFERENCE:String = "getNumericAttributes4SI";
		public static const GOT_NUMERIC_ATTRIBUTES_FOR_SOCIAL_INFERENCE:String = "gotNumericAttributes4SI";
		
		public static const GET_FILTER_ATTRIBUTES:String = "getFilterAttributes";
		public static const GOT_FILTER_ATTRIBUTES:String = "gotFilterAttributes";
		
		public static const GET_ATTRIBUTE_VALUES:String = "getAttributeValues";
		public static const GOT_ATTRIBUTE_VALUES:String = "gotAttributeValues";		
		
		public static const GET_PROPERTY_VALUES:String = "getPropertyValues";
		public static const GOT_PROPERTY_VALUES:String = "gotPropertyValues";
		
		public static const GET_EDGE_COLOR_ATTRIBUTES:String = "getEdgeColorAttributes";
		public static const GOT_EDGE_COLOR_ATTRIBUTES:String = "gotEdgeColorAttributes";
		
		public static const GET_EDGE_ATTRIBUTE_VALUES:String = "getEdgeAttributeValues";
		public static const GOT_EDGE_ATTRIBUTE_VALUES:String = "gotEdgeAttributeValues";
		
		public static const CONFIG_JOB_SETTINGS:String = "CONFIG_JOB_SETTINGS";
		
		// Invite.mxml
		public static const INVITE_USERS:String = "inviteUsers";
		public static const INVITE_USERS_DONE:String = "inviteUsersDone";
		
		public static const GET_USER_STATUS_MAP:String = "getUserStatusMap";
		public static const GET_USER_STATUS_MAP_DONE:String = "getUserStatusMapDone";
		
		//
		public static const GET_PROGRESS:String = "getProgress";
		public static const GET_PROGRESS_DONE:String = "getProgressDone";
		
		// VisColorSettings.mxml
		public static const GET_VIS_COLORS:String = "getVisColors";
		public static const GET_VIS_COLORS_DONE:String = "getVisColorsDone";
		public static const SAVE_VIS_COLORS:String = "saveVisColors";
		
		// for JobSettings.mxml
		public static const GET_SCHEDULED_JOBS:String = "getScheduledJobs";
		public static const GOT_SCHEDULED_JOBS:String = "gotScheduledJobs";
		public static const UPDATE_SCHEDULED_JOB:String = "updateScheduledJob";
		public static const DELETE_SCHEDULED_JOB:String = "deleteScheduledJob";
		public static const DELETED_SCHEDULED_JOB:String = "deletedScheduledJob";
		
		// for NetworkLimitPopup.mxml
		public static const GET_LARGE_NETWORK_LIMITS:String = "getLargeNetworkLimits";
		public static const GOT_LARGE_NETWORK_LIMITS:String = "gotLargeNetworkLimits";
		public static const SET_LARGE_NETWORK_LIMITS:String = "setLargeNetworkLimits";
		
		
		// SavedVisualization.mxml
		public static const GET_CREATED_VIS:String = "getCreatedVisualization";
		public static const GOT_CREATED_VIS:String = "gotCreatedVisualization";
		public static const GET_VISIBLE_VIS:String = "getVisibleVisualization";
		public static const GOT_VISIBLE_VIS:String = "gotVisibleVisualization";
		public static const CREATE_VIS:String = "createVis";
		public static const CREATED_VIS:String = "createdVis";
		public static const UPDATE_VIS:String = "updateVis";
		public static const UPDATED_VIS:String = "updatedVis";
		public static const DELETE_VIS:String = "deleteVis";
		public static const DELETED_VIS:String = "deletedVis";
		public static const VALIDATE_VIS:String = "validateVis";
		public static const VALIDATED_VIS:String = "validatedVis";
		
		// when normal authentication is turned off
		public static const PASSWORD_VERIFIED:String = "PasswordVerified";
		
		// init survey data
		public static const INITIALIZE_SURVEY:String = "INITIALIZE_SURVEY";
		public static const INITIALIZED_SURVEY:String = "INITIALIZED_SURVEY";
		
		// save question answers
		public static const SAVE_QUESTION_ANSWERS:String = "SAVE_QUESTION_ANSWERS";
		public static const SAVED_QUESTION_ANSWERS:String = "SAVED_QUESTION_ANSWERS";
		
		// collect OTHER information (choice, multiple choice, mutiple relational choice)
		public static const GOT_OTHER_INFO:String = "gotOtherInfo";
		
		// refresh data (app and survey)
		public static const REFRESH_DATA:String = "REFRESH_DATA";
		public static const REFRESHED_DATA:String = "REFRESHED_DATA";
		
		public var data:Object = new Object();
		
		public function GeneralEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new GeneralEvent(type, bubbles, cancelable);
		}
	}
}