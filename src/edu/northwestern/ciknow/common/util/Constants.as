package edu.northwestern.ciknow.common.util
{
	public class Constants
	{
		public function Constants()
		{
		}
		
		// general
		public static const LOGIN_MODE_DEFAULT:String = "default";
		public static const LOGIN_MODE_QUESTION_ONLY:String = "question-only";		
		public static const SEPERATOR:String = "`"; // used in QuestionUtil and TaggingUtil for key construction		
		public static const TAGGING_PREFIX:String = "tagging" + SEPERATOR; 
		//public static const PRIVATE_GROUP_PREFIX:String = "UG_";
		//public static const MANDATORY_GROUP_PREFIX:String = "MG_";
		
		// survey attributes
		public static const SURVEY_ADMIN_EMAIL:String = "SURVEY_ADMIN_EMAIL";
		public static const SURVEY_DEFAULT_PASSWORD:String = "SURVEY_DEFAULT_PASSWORD";
		public static const SURVEY_SHOW_LOGIN_LIST:String = "SURVEY_SHOW_LOGIN_LIST";
		public static const SURVEY_DEFAULT_LOGIN_MODE:String = "SURVEY_DEFAULT_LOGIN_MODE";
		public static const SURVEY_LAST_UPDATE_USERNAME:String = "SURVEY_LAST_LOGIN_USERNAME";		
		public static const SURVEY_ALLOW_SELF_REGISTER:String = "SURVEY_ALLOW_SELF_REGISTER";
		public static const SURVEY_SELF_REGISTER_GROUPS:String = "SURVEY_SELF_REGISTER_GROUPS";
		public static const SURVEY_FORCE_NEW_USER_CHANGE_PASSWD:String = "SURVEY_FORCE_NEW_USER_CHANGE_PASSWORD";
		public static const SURVEY_SHOW_SURVEY:String = "SURVEY_SHOW_SURVEY";
		public static const SURVEY_SHOW_GAME:String = "SURVEY_SHOW_GAME";
		public static const SURVEY_SHOW_REPORT:String = "SURVEY_SHOW_REPORT";
		public static const SURVEY_SHOW_RAW_ATTRIBUTES_IN_REPORT:String = "SURVEY_SHOW_RAW_ATTRIBUTES_IN_REPORT";
		public static const SURVEY_SHOW_VIS:String = "SURVEY_SHOW_VIS";
		public static const SURVEY_ALLOW_SNAPSHOT:String = "SURVEY_ALLOW_SNAPSHOT";
		public static const SURVEY_SHOW_REC:String = "SURVEY_SHOW_REC";		
		public static const SURVEY_DISABLE_USER_ON_FINISH:String = "SURVEY_DISABLE_USER_ON_FINISH";
		
		public static const SURVEY_SHOW_NAVIGATION_DURING:String = "SURVEY_SHOW_NAVIGATION_DURING";
		public static const SURVEY_SHOW_NAVIGATION_AFTER:String = "SURVEY_SHOW_NAVIGATION_AFTER";
		
		public static const SURVEY_REQUIRE_PASSWORD:String = "SURVEY_REQUIRE_PASSWORD";
		public static const SURVEY_PASSWORD:String = "SURVEY_PASSWORD"; // password to protect the survey which is exposed without authentication
		
		public static const SURVEY_POST_NOTICE:String = "SURVEY_POST_NOTICE";
		public static const SURVEY_NOTICE_CONTENT:String = "SURVEY_NOTICE_CONTENT";
		public static const SURVEY_NOTICE_GROUP:String = "SURVEY_NOTICE_GROUP";
		public static const SURVEY_NOTICE_FREQUENCY:String = "SURVEY_NOTICE_FREQUENCY";
		public static const SURVEY_NOTICE_FREQUENCY_FIRST_TIME:String = "SURVEY_NOTICE_FREQUENCY_FIRST_TIME";
		public static const SURVEY_NOTICE_FREQUENCY_EVERY_TIME:String = "SURVEY_NOTICE_FREQUENCY_EVERY_TIME";
		public static const SURVEY_NOTICE_WIDTH:String = "SURVEY_NOTICE_WIDTH";
		public static const SURVEY_NOTICE_HEIGHT:String = "SURVEY_NOTICE_HEIGHT";
		public static const SURVEY_NOTICE_BACKGROUND:String = "SURVEY_NOTICE_BACKGROUND";
		
		public static const SURVEY_DEFAULT_LOCALE:String = "SURVEY_DEFAULT_LOCALE";
		
		
		
		// node attributes
		public static const NODE_LOGIN_MODE:String = "NODE_LOGIN_MODE";
		public static const NODE_TS_PREFIX:String = "NODE_TS_";
		public static const NODE_TS_START_SURVEY:String = "NODE_TS_START_SURVEY";
		public static const NODE_TS_FINISH_SURVEY:String = "NODE_TS_FINISH_SURVEY";
		public static const NODE_MAX_ANSWERED_QUESTION_NAME:String = "NODE_MAX_ANSWERED_QUESTION_NAME";
		public static const NODE_LAST_ANSWERED_QUESTION_NAME:String = "NODE_LAST_ANSWERED_QUESTION_NAME";
		public static const NODE_LAST_ANSWERED_QUESTION_TIME:String = "NODE_LAST_ANSWERED_QUESTION_TIME";
		public static const NODE_FIRST_TIMER:String = "NODE_FIRST_TIMER";
		public static const NODE_JUMP_FROM_TO_QUESTIONS:String = "jumpFromToQuestions";
		public static const NODE_SKIP_FROM_TO_QUESTIONS:String = "skipFromToQuestions";
		
		public static const NODE_PROGRESS_FINISHED:String = "FINISHED";
		public static const NODE_PROGRESS_COMPLETED:String = "COMPLETED";
		public static const NODE_PROGRESS_NOT_COMPLETED:String = "NOT_COMPLETED";
		public static const NODE_PROGRESS_NOT_STARTED:String = "NOT_STARTED";
		public static const NODE_PROGRESS_ANY:String = "ANY";
		
		// question attributes
		public static const DEFAULT_FIELD:String = "defaultField"; // choice.mxml
		public static const DEFAULT_SCALE:String = "defaultScale"; // rating.mxml, relationalrating.mxml
		public static const CHOICE_LIMIT:String = "choiceLimit"; // choice.mxml
		public static const SHOW_SINGLE_CHOICE_AS_LIST:String = "showSingleChoiceAsList";
		public static const DISPLAY_RATING_AS_DROPDOWN_LIST:String = "displayRatingAsDropdownList"; // rating, relational rating.mxml
		public static const SHOW_SELECT_ALL:String = "showSelectAll"; // choice.mxml and relationalChoice.mxml
		public static const ALLOW_USER_CHOICE:String = "allowUserChoice"; // choice.mxml
		public static const EXPORT_BY_COLUMN:String = "exportByColumn"; // percived relational choice/rating
		// if contact chooser is used and respondent does not select any (availableNodes is empty), skip the quesiton
		public static const SKIP_ON_EMPTY:String = "SKIP_ON_EMPTY"; 
		public static const SKIP_ON_INACTIVITY:String = "SKIP_ON_INACTIVITY";
		public static const CC_LEVEL:String = "ccLevel"; // CCConfig.xml
		public static const CC_DEFAULT:String = "default"; // default value if the specified attribute is absent
		public static const CC_SHORT_NAME:String = "ccShortName"; // contact chooser question shortName linked to a question
		public static const CC_NEGATE:String = "ccNegate";	// negate the contact chooser
		public static const CC_SELECTED_NODES_HEADER:String = "ccSelectedNodesHeader";
		
		public static const CC_EMPTY:String = "ccEmpty";
		public static const CC_EMPTY_ALL:String = "ALL";
		public static const CC_EMPTY_NONE:String = "NONE";
		
		public static const NEW_CONTACT_DEFAULT_TYPE:String = "newContactDefaultType"; // Msic.mxml
		public static const ROW_PER_HEADER:String = "rowPerHeader";
		public static const SINGLE_CHOICE_PER_LINE:String = "singleChoicePerLine";	// for multiple relation choice question type only
		public static const JUMP_CONDITION:String = "jumpCondition";
		public static const JUMP_QUESTION:String = "jumpQuestion";		
		public static const CONTACT_CHOOSER_SHOW_RETURN_BTN:String = "contactChooserShowReturnBtn";
		public static const CONTACT_CHOOSER_FROM_QUESTION:String = "contactChooserFromQuestion";
		public static const SHOW_IMAGE:String = "showImage";	// for contact chooser question
		public static const ALLOW_PRINT:String = "allowPrint";
		public static const RECORD_DURATION:String = "recordDuration"; // for relational continous question
		public static const ALLOW_USER_CREATED_NODE:String = "allowUserCreatedNode";
		public static const HIDE_CONTACT_CHOOSER_INSTRUCTION:String = "hideContactChooserInstruction";
		
		public static const ADG_COLUMN_WIDTH:String = "AdvancedDataGridColumnWidth";	// ContactChooser.mxml
		public static const ADG_COLUMN_FIELDS:String = "ccLevel";	// ContactChooser, CCConfig.mxml
		public static const ADG_COLUMN_SORT_FIELDS:String = "adgColumnSortFields";	// ContactChooser, CCSort.mxml
		
		public static const OPTION_HIDDEN:String = "Option_HiddenFromVisulization";
		public static const OPTION_SINGLE_CHOICE:String = "Option_IsSingleChoice";
		public static const OPTION_ALLOW_USER_CREATE_CHOICE:String = "Option_AllowUserCreateChoice";
		public static const OPTION_SHOW_USER_CONTACTS_ONLY:String = "Option_ShowUserContactsOnly";
		public static const OPTION_SHOW_SELF:String = "Option_ShowSelf";
		
		// this is a reserve word/field for choice, multiple choice and multiple relational choice question type
		public static const OTHER:String = "other"; 
		
		// question types
		public static const QUESTION_TYPE_CHOICE:String = "Choice";
		public static const QUESTION_TYPE_CONTINUOUS:String = "Continuous";
		public static const QUESTION_TYPE_TEXT_LONG:String = "TextLong";
		public static const QUESTION_TYPE_DURATION_CHOOSER:String = "DurationChooser";
		public static const QUESTION_TYPE_RATING:String = "Rating";
		public static const QUESTION_TYPE_TEXT:String = "Text";
		//public static const QUESTION_TYPE_TEXT_QUICK:String = "TextQuick";
		public static const QUESTION_TYPE_CONTACT_INFO:String = "ContactInfo";
		public static const QUESTION_TYPE_RELATIONAL_CHOICE:String = "RelationalChoice";
		public static const QUESTION_TYPE_RELATIONAL_CONTINUOUS:String = "RelationalContinuous";
		public static const QUESTION_TYPE_RELATIONAL_RATING:String = "RelationalRating";
		public static const QUESTION_TYPE_PERCEIVED_CHOICE:String = "PerceivedChoice";
		public static const QUESTION_TYPE_PERCEIVED_RATING:String = "PerceivedRating";
		public static const QUESTION_TYPE_PERCEIVED_RELATIONAL_CHOICE:String = "PerceivedRelationalChoice";
		public static const QUESTION_TYPE_PERCEIVED_RELATIONAL_RATING:String = "PerceivedRelationalRating";
		public static const QUESTION_TYPE_CONTACT_CHOOSER:String = "ContactChooser";
		public static const QUESTION_TYPE_CONTACT_PROVIDER:String = "ContactProvider";
		public static const QUESTION_TYPE_DISPLAY_PAGE:String = "DisplayPage";
		public static const QUESTION_TYPE_RELATIONAL_CHOICE_MULTIPLE:String = "RelationalChoiceMultiple";
		public static const QUESTION_TYPE_RELATIONAL_RATING_MULTIPLE:String = "RelationalRatingMultiple";				
		public static const QUESTION_TYPE_MULTIPLE_CHOICE:String = "MultipleChoice";
		public static const QUESTION_TYPE_MULTIPLE_RATING:String = "MultipleRating";
		
		// contact fields				
		public static const CONTACT_FIELD_ADDR1:String = "Address 1";
		public static const CONTACT_FIELD_ADDR2:String = "Address 2";
		public static const CONTACT_FIELD_CITY:String = "City";
		public static const CONTACT_FIELD_STATE:String = "State";
		public static const CONTACT_FIELD_COUNTRY:String = "Country";
		public static const CONTACT_FIELD_ZIP:String = "Zip";
		public static const CONTACT_FIELD_PHONE:String = "Phone";
		public static const CONTACT_FIELD_CELL:String = "Cell";
		public static const CONTACT_FIELD_FAX:String = "Fax";
		public static const CONTACT_FIELD_EMAIL:String = "Email";
		public static const CONTACT_FIELD_URL:String = "URL";
		public static const CONTACT_FIELD_DEPARTMENT:String = "Department";
		public static const CONTACT_FIELD_ORGANIZATION:String = "Organization";
		public static const CONTACT_FIELD_UNIT:String = "Unit";	
		
		
		// network type
		public static const NETWORK_LOCAL:String = "local";	
		public static const NETWORK_CUSTOM:String = "custom";
		public static const NETWORK_RECOMMENDER:String = "recommender";
		
		// recommendation metrics
		public static const PEARSON:String = "pearson";
		public static const COSINE:String = "cosine";
		public static const EUCLIDEAN:String = "euclidean";
		public static const SEUCLIDEAN:String = "seuclidean";
		public static const PMATCH:String = "pmatch";
		public static const SPMATCH:String = "spmatch";
		//public static const GEODESIC:String = "geodesic";
		public static const SP:String = "sp";
		public static const ERGM:String = "ergm";
		public static const SIMILARITY:String = "similarity";
		
		// mahout
		public static const MAHOUT_RECOMMENDER_TYPE_USER:String = "GenericUserBasedRecommender";
		public static const MAHOUT_RECOMMENDER_TYPE_USER_BOOLEAN:String = "GenericBooleanPrefUserBasedRecommender";
		public static const MAHOUT_RECOMMENDER_TYPE_ITEM:String = "GenericItemBasedRecommender";
		public static const MAHOUT_RECOMMENDER_TYPE_SLOPEONE:String = "SlopeOneRecommender";
		public static const MAHOUT_SIMILARITY_PEARSON:String = "PearsonCorrelationSimilarity";
		public static const MAHOUT_SIMILARITY_EUCLIDEAN:String = "EuclideanDistanceSimilarity";
		public static const MAHOUT_SIMILARITY_SPEARMAN:String = "SpearmanCorrelationSimilarity";
		public static const MAHOUT_SIMILARITY_COSINE:String = "UncenteredCosineSimilarity";
		public static const MAHOUT_SIMILARITY_TANIMOTO:String = "TanimotoCoefficientSimilarity";
		public static const MAHOUT_SIMILARITY_LOG:String = "LogLikelihoodSimilarity";
		public static const MAHOUT_NEIGHBORHOOD_NEARESTN:String = "NearestNUserNeighborhood";
		public static const MAHOUT_NEIGHBORHOOD_THRESHOLD:String = "ThresholdUserNeighborhood";	
		
		public static const MAHOUT_EVALUATION_TYPE_DIFF:String = "diff";
		public static const MAHOUT_EVALUATION_TYPE_IR:String = "irstats";
		public static const MAHOUT_EVALUATION_TYPE_PERFORMANCE:String = "performance";
		public static const MAHOUT_EVALUATOR_AVERAGE_ABSOLUTE_DIFF:String = "AverageAbsoluteDifferenceRecommenderEvaluator";
		public static const MAHOUT_EVALUATOR_RMS:String = "RMSRecommenderEvaluator";
		public static const MAHOUT_EVALUATOR_GENERIC_IRSTATS:String = "GenericRecommenderIRStatsEvaluator";
		
		// membership
		public static const NODE_TYPE_USER:String = "user";
		public static const GROUP_ALL:String = "ALL";
		public static const GROUP_USER:String = "USER";
		public static const GROUP_NODE_TYPE_PREFIX:String = "TYPE_";
		public static const GROUP_DEPT_PREFIX:String = "DEPT_";
		public static const GROUP_ORGANIZATION_PREFIX:String = "ORG_";
		public static const GROUP_UNIT_PREFIX:String = "UNIT_";
		public static const ROLE_ADMIN:String = "ROLE_ADMIN";
		public static const ROLE_HIDDEN:String = "ROLE_HIDDEN";
		public static const ROLE_USER:String = "ROLE_USER";
		
		// cron
		public static const JOB_MINUTELY:String = "minutely";
		public static const JOB_HOURLY:String = "hourly";
		public static const JOB_DAILY:String = "daily";
		public static const JOB_WEEKLY:String = "weekly";
		public static const JOB_MONTHLY:String = "monthly";
		public static const JOB_YEARLY:String = "yearly";
		
		// message
		public static const MSG_ANNOUNCEMENT:Number = 1;
		public static const MSG_WARNING:Number = 2;
		
		// derivation
		public static const SYMMETRIZE:String = "symmetrize";		
		public static const S_MAX:String = "s_max";
		public static const S_MIN:String = "s_min";
		public static const S_AVR:String = "s_average";
		
		public static const DERIVE_EDGE_BY_RELATION:String="deriveEdgeByRelation";
		public static const DERIVE_EDGE_BY_ATTRIBUTE:String="deriveEdgeByAttribute";
		public static const DERIVE_EDGE_BY_CC:String="deriveEdgeByContactChooser";
		public static const DERIVE_EDGE_BY_SYMMETRIZATION:String="deriveEdgeBySymmetrization";
		public static const DERIVE_ATTRIBUTE_BY_PRODUCT:String="deriveAttributeByProduct";
		public static const DERIVE_ATTRIBUTE_BY_ANALYTICS:String="deriveAttributeByAnalytics";
		public static const DERIVE_ATTRIBUTE_BY_EQUATION:String="deriveAttributeByEquation";
		public static const DERIVE_ATTRIBUTE_BY_SI:String="deriveAttributeBySocialInfluence";
		public static const DERIVE_ATTRIBUTE_BY_PROGRESS:String="deriveAttributeByProgress";
		
		// visualization
		public static const ATTR_PREFIX:String = "ATTR:";
		public static const QUESTION_PREFIX:String = "QUESTION:";
		
		
		
		// deep linking
		
		public static const M_SURVEY:String = "survey";
		public static const M_REPORT:String = "report";
		public static const M_VISA:String = "visa";
		public static const M_RECOMMENDATION:String = "rec";
		public static const M_ADMINISTRATION:String = "admin";
		public static const M_DOCUMENTATION:String = "doc";
		
		public static const T_PREFERENCES:String = "pref";
		public static const T_NODES:String = "nodes";
		public static const T_SURVEYDESIGN:String = "sd";
		public static const T_LABELS:String = "label";
		public static const T_DERIVATION:String = "derivation";
		public static const T_IMPORTEXPORT:String = "io";
		public static const T_RECOMMENDATION:String = "rec";
		public static const T_PASSWORD:String = "pw";
		public static const T_MEMBERSHIP:String = "membership";
		public static const T_MORE:String = "more";
		
		public static const T_NETWORK:String = "network";
		public static const T_SAVEDVIS:String = "sv";
		public static const T_CHART:String = "chart";
		
		public static const T_NODEREPORT:String = "nodereport";
		public static const T_PROGRESS:String = "progress";
		
		public static const T_PULLRECOMMENDER:String = "pr";
		public static const T_TEAMASSEMBLY:String = "ta";
		
	}
}