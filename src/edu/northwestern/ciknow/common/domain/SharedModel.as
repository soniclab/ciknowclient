package edu.northwestern.ciknow.common.domain
{	
	import edu.northwestern.ciknow.common.util.CIKNOWAssets;
	import edu.northwestern.ciknow.common.util.Constants;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.managers.IBrowserManager;
	
	[Bindable]
	public class SharedModel
	{	
		// BrowserManager (for deep linking)
		public var bm:IBrowserManager = null;
		
		//public var assets:CIKNOWAssets = new CIKNOWAssets();
		public var offline:Boolean = false;
		public var baseURL:String = "";
		public var authenticated:Boolean = false;
		public var indexPage:Sprite;	
		public var loginNode:NodeDTO;
		public var currentSurvey:SurveyDTO;
		//public var latLngCache:Object = new Object();
		public var nodeMap:Object = null; 	// nodeId -> plain nodes mapping
		public var allUsernames:ArrayCollection = null;
		public var allNodeLabels:ArrayCollection = null;
		public var recConfigXML:XML = null;	
		
		public var mainPageHeight:Number = -1;
		public var mainPageWidth:Number = -1;
		
		public var nodeTypeDescriptions:ArrayCollection = new ArrayCollection();
		public var edgeTypeDescriptions:ArrayCollection = new ArrayCollection();
		
		/* these collections must be processed with IDataCache in AppContext */
		//public var nodes:ArrayCollection = new ArrayCollection();	
		public var groups:ArrayCollection = new ArrayCollection();	
		public var roles:ArrayCollection = new ArrayCollection();		
		public var surveys:ArrayCollection = new ArrayCollection();
		public var questions:ArrayCollection = new ArrayCollection();
		

		
		/****************************************************************************************************************************
		 * Static Data
		 * **************************************************************************************************************************/
		public const loginModes:ArrayCollection = new ArrayCollection
			(
				[{key:Constants.LOGIN_MODE_DEFAULT, label:"Complete"},
					{key:Constants.LOGIN_MODE_QUESTION_ONLY, label:"Survey"}]
			); 
		
		public const questionTypes:ArrayCollection = new ArrayCollection([{type:Constants.QUESTION_TYPE_CHOICE, label:Constants.QUESTION_TYPE_CHOICE, tip:"single or multiple choice question"},
			{type:Constants.QUESTION_TYPE_RATING, label:Constants.QUESTION_TYPE_RATING, tip:"rating question"},
			{type:Constants.QUESTION_TYPE_CONTINUOUS, label:Constants.QUESTION_TYPE_CONTINUOUS, tip:""},
			{type:Constants.QUESTION_TYPE_TEXT, label:Constants.QUESTION_TYPE_TEXT, tip:"collect text response"},
			//{type:Constants.QUESTION_TYPE_TEXT_QUICK, label:Constants.QUESTION_TYPE_TEXT_QUICK, tip:"collect text input for multiple nodes"},
			{type:Constants.QUESTION_TYPE_TEXT_LONG, label:Constants.QUESTION_TYPE_TEXT_LONG, tip:"collect long ( > 1024 char) text response"},
			{type:Constants.QUESTION_TYPE_CONTACT_CHOOSER, label:Constants.QUESTION_TYPE_CONTACT_CHOOSER, tip:"select list of contacts used by relational questions later"},																				
			{type:Constants.QUESTION_TYPE_RELATIONAL_CHOICE, label:Constants.QUESTION_TYPE_RELATIONAL_CHOICE, tip:"determine the relations among login user and selected contacts"},
			{type:Constants.QUESTION_TYPE_RELATIONAL_RATING, label:Constants.QUESTION_TYPE_RELATIONAL_RATING, tip:"rate the relations among login user and selected contacts"},
			{type:Constants.QUESTION_TYPE_CONTACT_INFO, label:Constants.QUESTION_TYPE_CONTACT_INFO, tip:"collect contact information of login user"},
			{type:Constants.QUESTION_TYPE_DISPLAY_PAGE, label:Constants.QUESTION_TYPE_DISPLAY_PAGE, tip:"display plain text"},										
			{type:Constants.QUESTION_TYPE_MULTIPLE_CHOICE, label:Constants.QUESTION_TYPE_MULTIPLE_CHOICE, tip:"aggregate multiple 'choice' question into one"},
			{type:Constants.QUESTION_TYPE_MULTIPLE_RATING, label:Constants.QUESTION_TYPE_MULTIPLE_RATING, tip:"aggregate multiple 'rating' question into one"},										
			{type:Constants.QUESTION_TYPE_RELATIONAL_CHOICE_MULTIPLE, label:"MultipleRelationalChoice", tip:"aggregate multiple 'relational choice' question into one"},
			{type:Constants.QUESTION_TYPE_RELATIONAL_RATING_MULTIPLE, label:"MultipleRelationalRating", tip:"aggregate multiple 'relational rating' question into one"},																				
			{type:Constants.QUESTION_TYPE_DURATION_CHOOSER, label:Constants.QUESTION_TYPE_DURATION_CHOOSER, tip:"choose duration"}, 
			{type:Constants.QUESTION_TYPE_PERCEIVED_RELATIONAL_CHOICE, label:Constants.QUESTION_TYPE_PERCEIVED_RELATIONAL_CHOICE, tip:"perceive relations among selected contacts"},	
			{type:Constants.QUESTION_TYPE_PERCEIVED_RELATIONAL_RATING, label:Constants.QUESTION_TYPE_PERCEIVED_RELATIONAL_RATING, tip:"perceive/rate relations among selected contacts"},									
			{type:Constants.QUESTION_TYPE_PERCEIVED_CHOICE, label:Constants.QUESTION_TYPE_PERCEIVED_CHOICE, tip:""},
			{type:Constants.QUESTION_TYPE_PERCEIVED_RATING, label:Constants.QUESTION_TYPE_PERCEIVED_RATING, tip:""},										
			{type:Constants.QUESTION_TYPE_RELATIONAL_CONTINUOUS, label:Constants.QUESTION_TYPE_RELATIONAL_CONTINUOUS, tip:""}]);
		
		
		public const JOB_SCHEDULES:ArrayCollection = new ArrayCollection( [
			{name:Constants.JOB_MINUTELY, label:Constants.JOB_MINUTELY, tip:"0 * * * * ?"},
			{name:Constants.JOB_HOURLY, label:Constants.JOB_HOURLY, tip:"0 0 * * * ?"},
			{name:Constants.JOB_DAILY, label:Constants.JOB_DAILY, tip:"0 0 0 * * ?"},
			{name:Constants.JOB_WEEKLY, label:Constants.JOB_WEEKLY, tip:"0 0 0 ? * SUN"},
			{name:Constants.JOB_MONTHLY, label:Constants.JOB_MONTHLY, tip:"0 0 0 1 * ?"},
			{name:Constants.JOB_YEARLY, label:Constants.JOB_YEARLY, tip:"0 0 0 1 JAN ? *"}
		]);

		// this is be synchronized with Constants.java in the server
		public const COLORABLE_PROPERTIES:ArrayCollection = 
			new ArrayCollection(
			[{name:"type", label:"type"},
			{name:"city", label:"city"},
			{name:"state", label:"state"},
			{name:"country", label:"country"},
			{name:"zipcode", label:"zipcode"},
			{name:"organization", label:"organization"},
			{name:"department", label:"department"},
			{name:"unit", label:"unit"}]
			);
		
		
		public const CC_EMPTY_STRATEGIES:ArrayCollection = new ArrayCollection(
			[{name:Constants.CC_EMPTY_ALL, label:"All"},
				{name:Constants.CC_EMPTY_NONE, label:"None"}]);
																	

		public const SYMMETRIZE_STRATEGIES:ArrayCollection = new ArrayCollection([{name:Constants.S_MAX, label:"Max"},
															{name:Constants.S_MIN, label:"Min"},
															{name:Constants.S_AVR, label:"Average"}]);	
		

		public const PREDEFINED_CONTACT_FIELDS:ArrayCollection = new ArrayCollection([{name:Constants.CONTACT_FIELD_ADDR1, label:Constants.CONTACT_FIELD_ADDR1},
																{name:Constants.CONTACT_FIELD_ADDR2, label:Constants.CONTACT_FIELD_ADDR2},
																{name:Constants.CONTACT_FIELD_CITY, label:Constants.CONTACT_FIELD_CITY},
																{name:Constants.CONTACT_FIELD_STATE, label:Constants.CONTACT_FIELD_STATE},
																{name:Constants.CONTACT_FIELD_COUNTRY, label:Constants.CONTACT_FIELD_COUNTRY},
																{name:Constants.CONTACT_FIELD_ZIP, label:Constants.CONTACT_FIELD_ZIP},
																{name:Constants.CONTACT_FIELD_PHONE, label:Constants.CONTACT_FIELD_PHONE},
																{name:Constants.CONTACT_FIELD_CELL, label:Constants.CONTACT_FIELD_CELL},
																{name:Constants.CONTACT_FIELD_FAX, label:Constants.CONTACT_FIELD_FAX},
																{name:Constants.CONTACT_FIELD_EMAIL, label:Constants.CONTACT_FIELD_EMAIL},
																{name:Constants.CONTACT_FIELD_URL, label:Constants.CONTACT_FIELD_URL},
																{name:Constants.CONTACT_FIELD_DEPARTMENT, label:Constants.CONTACT_FIELD_DEPARTMENT},
																{name:Constants.CONTACT_FIELD_ORGANIZATION, label:Constants.CONTACT_FIELD_ORGANIZATION},
																{name:Constants.CONTACT_FIELD_UNIT, label:Constants.CONTACT_FIELD_UNIT}]);
			

		public const SIMILARITIES:ArrayCollection = new ArrayCollection([Constants.PEARSON, 
												Constants.COSINE, 
												Constants.EUCLIDEAN, 
												Constants.SEUCLIDEAN, 
												Constants.PMATCH, 
												Constants.SPMATCH]);
		
	
		public const mahoutRecTypes:ArrayCollection = new ArrayCollection([
			{label:Constants.MAHOUT_RECOMMENDER_TYPE_USER, data:Constants.MAHOUT_RECOMMENDER_TYPE_USER},
			{label:Constants.MAHOUT_RECOMMENDER_TYPE_USER_BOOLEAN, data:Constants.MAHOUT_RECOMMENDER_TYPE_USER_BOOLEAN},
			{label:Constants.MAHOUT_RECOMMENDER_TYPE_ITEM, data:Constants.MAHOUT_RECOMMENDER_TYPE_ITEM},
			{label:Constants.MAHOUT_RECOMMENDER_TYPE_SLOPEONE, data:Constants.MAHOUT_RECOMMENDER_TYPE_SLOPEONE}
		]);
		
		public const mahoutSimTypes:ArrayCollection = new ArrayCollection([
			{label:Constants.MAHOUT_SIMILARITY_PEARSON, data:Constants.MAHOUT_SIMILARITY_PEARSON},
			{label:Constants.MAHOUT_SIMILARITY_EUCLIDEAN, data:Constants.MAHOUT_SIMILARITY_EUCLIDEAN},
			{label:Constants.MAHOUT_SIMILARITY_SPEARMAN, data:Constants.MAHOUT_SIMILARITY_SPEARMAN},
			{label:Constants.MAHOUT_SIMILARITY_COSINE, data:Constants.MAHOUT_SIMILARITY_COSINE},
			{label:Constants.MAHOUT_SIMILARITY_TANIMOTO, data:Constants.MAHOUT_SIMILARITY_TANIMOTO},
			{label:Constants.MAHOUT_SIMILARITY_LOG, data:Constants.MAHOUT_SIMILARITY_LOG}
		]);
		
		public const mahoutNeighborhoodTypes:ArrayCollection = new ArrayCollection([
			{label:Constants.MAHOUT_NEIGHBORHOOD_NEARESTN, data:Constants.MAHOUT_NEIGHBORHOOD_NEARESTN},
			{label:Constants.MAHOUT_NEIGHBORHOOD_THRESHOLD, data:Constants.MAHOUT_NEIGHBORHOOD_THRESHOLD}
		]);

		public const mahoutEvaluationTypes:ArrayCollection = new ArrayCollection([
			{label:"Difference", data:Constants.MAHOUT_EVALUATION_TYPE_DIFF},
			{label:"Information Retrieval Statistics", data:Constants.MAHOUT_EVALUATION_TYPE_IR},
			{label:"Runtime Performance", data:Constants.MAHOUT_EVALUATION_TYPE_PERFORMANCE}
		]);
		
		public const mahoutEvaluationDiffTypes:ArrayCollection = new ArrayCollection([
			{label:Constants.MAHOUT_EVALUATOR_AVERAGE_ABSOLUTE_DIFF, data:Constants.MAHOUT_EVALUATOR_AVERAGE_ABSOLUTE_DIFF},
			{label:Constants.MAHOUT_EVALUATOR_RMS, data:Constants.MAHOUT_EVALUATOR_RMS}
		]);
		
		
		public const MSG_TYPES:ArrayCollection = new ArrayCollection([{label:"Announcement", value:Constants.MSG_ANNOUNCEMENT}, 
												{label:"Warning", value:Constants.MSG_WARNING}]);
	      	
	}
}