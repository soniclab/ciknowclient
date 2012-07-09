package edu.northwestern.ciknow.common.util
{
	import edu.northwestern.ciknow.common.domain.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.logging.Log;
		
	public class QuestionUtil
	{
		public static var p:RegExp = / /g;
		private static const logger:ILogger = LogUtil.getLog(QuestionUtil);
		
		[Inject]
		public var model:SharedModel;
		[Inject]
		public var gu:GeneralUtil;
		[Inject]
		public var nu:NodeUtil; // circular reference between questionUtil and nodeUtil
		
		public function getQuestionById(questions:ArrayCollection, id:Number):QuestionDTO{
			for each (var question:QuestionDTO in questions){
				if (question.questionId == id) return question;
			}
			return null;			
		}
		
		public function getQuestionByShortName(questions:ArrayCollection, shortName:String):QuestionDTO{
			for each (var question:QuestionDTO in questions){
				if (question.shortName == shortName) return question;
			}
			return null;
		}
			
		public function getQuestionByLabel(questions:ArrayCollection, label:String):QuestionDTO{
			for each (var question:QuestionDTO in questions){
				if (question.label == label) return question;
			}
			return null;
		}
					
   		public function getEdgeType(question:QuestionDTO, field:FieldDTO = null):String{
  			if (question == null){
  				Alert.show("please specify question.");
  				return null;
  			}
  			
  			if (question.type == Constants.QUESTION_TYPE_RELATIONAL_CHOICE_MULTIPLE ||
  				question.type == Constants.QUESTION_TYPE_RELATIONAL_RATING_MULTIPLE){
  					if (field != null) return question.shortName + Constants.SEPERATOR + field.name;
  					else {
	  					var msg:String = "please specify both question and field for question type: " + question.type;
	  					Alert.show(msg);
	  					return null;
  					}
  				}
  				
  			else if (question.type == Constants.QUESTION_TYPE_PERCEIVED_CHOICE ||
  				question.type == Constants.QUESTION_TYPE_PERCEIVED_RATING){
  					return Constants.TAGGING_PREFIX + question.shortName;
  				}
  			else if (question.type == Constants.QUESTION_TYPE_RELATIONAL_CHOICE	
  					|| question.type == Constants.QUESTION_TYPE_RELATIONAL_RATING
  					|| question.type == Constants.QUESTION_TYPE_RELATIONAL_CONTINUOUS
  					|| question.type == Constants.QUESTION_TYPE_PERCEIVED_RELATIONAL_CHOICE
  					|| question.type == Constants.QUESTION_TYPE_PERCEIVED_RELATIONAL_RATING
  					|| question.type == Constants.QUESTION_TYPE_CONTACT_CHOOSER){
  						return question.shortName;
  					}
			else return null;
		}   	
		
		public function getQuestionByEdgeType(edgeType:String):QuestionDTO{
			if (edgeType == null) {
				Alert.show("please specify edgeType.");
				return null;
			}
			
			var index:Number = edgeType.indexOf(Constants.SEPERATOR);
			var shortName:String;
			if (edgeType.indexOf(Constants.TAGGING_PREFIX) == 0) {
				shortName = edgeType.substring(index+1);
			} else if (index >= 0) shortName = edgeType.substring(0, index);
			else shortName = edgeType;
			
			return getQuestionByShortName(model.questions, shortName);
		}
					
		public function getQuestionTypeLabelByQuestionType(type:String):String{
			for each (var item:Object in model.questionTypes){
				if (item.type == type) return item.label;
			}
			return "UNKNOWN TYPE";
		}
		
		/////////////// get fields/scales/contactfield/textfield ///////////////
		public function getFieldByName(question:QuestionDTO, name:String):FieldDTO{
			for each (var field:FieldDTO in question.fields){
				if (field.name == name) return field;
			}
			return null;
		}
		
		public function getFieldByLabel(question:QuestionDTO, label:String):FieldDTO{
			for each (var field:FieldDTO in question.fields){
				if (field.label == label) return field;
			}
			return null;
		}		
		
		public function getScaleByName(question:QuestionDTO, name:String):ScaleDTO{
			for each (var scale:ScaleDTO in question.scales){
				if (scale.name == name) return scale;
			}
			return null;
		}
				
 		public function getContactFieldByLabel(question:QuestionDTO, label:String):ContactFieldDTO{
			for each (var field:ContactFieldDTO in question.contactFields){
				if (field.label == label) return field;
			}
			return null;
		} 
		
		public function getTextFieldByName(question:QuestionDTO, name:String):TextFieldDTO{
			for each (var field:TextFieldDTO in question.textFields){
				if (field.name == name) return field;
			}
			return null;
		}
		
		public function getTextFieldByLabel(question:QuestionDTO, label:String):TextFieldDTO{
			for each (var field:TextFieldDTO in question.textFields){
				if (field.label == label) return field;
			}
			return null;
		}
		
		////////////////////// make keys ////////////////////////
 		public function makeFieldKey(question:QuestionDTO, field:FieldDTO):String{
			return "F" + Constants.SEPERATOR + question.shortName + Constants.SEPERATOR + field.name;
		} 
		
 		public function makeFieldsKey(question:QuestionDTO, field:FieldDTO, tf:TextFieldDTO):String{
			return "FT" + 
					Constants.SEPERATOR + question.shortName + 
					Constants.SEPERATOR + field.name + 
					Constants.SEPERATOR + tf.name;
		} 		
		
		public function getShortNameFromKey(key:String):String{
			var arr:Array = key.split(Constants.SEPERATOR);
			return arr[1];
		}
					
		public function getFieldNameFromKey(key:String):String{
			var arr:Array = key.split(Constants.SEPERATOR);
			return arr[2];
		}
		
		public function getTextFieldNameFromKeys(key:String):String{
			var arr:Array = key.split(Constants.SEPERATOR);
			return arr[3];
		}		
						
		public function makeScaleKey(question:QuestionDTO,scale:ScaleDTO):String{
			return "S" + Constants.SEPERATOR + question.shortName + Constants.SEPERATOR + scale.name;
		}
		
		public function getScaleNameFromKey(key:String):String{
			var arr:Array = key.split(Constants.SEPERATOR);
			return arr[2];
		}
		
		public function makeTextFieldKey(question:QuestionDTO, field:TextFieldDTO):String{
			return "T" + Constants.SEPERATOR + question.shortName + Constants.SEPERATOR + field.name;
		}
		
		public function getTextFieldNameFromKey(key:String):String{
			var arr:Array = key.split(Constants.SEPERATOR);
			return arr[2];
		}
		
		public function makeContactFieldKey(question:QuestionDTO, cf:ContactFieldDTO):String{
			return "CF" + Constants.SEPERATOR + question.shortName + Constants.SEPERATOR + cf.name;
		}
		
		public function getContactFieldNameFromKey(key:String):String{
			var arr:Array = key.split(Constants.SEPERATOR);
			return arr[2];
		}			
		
		public function createDuration(year:uint, month:uint, day:uint, 
												hour:uint, minute:uint, second:uint):String{
			return year + ":" + month + ":" + day + ":" + hour + ":" + minute + ":" + second;
		}	
		
		public function getByIndex(duration:String, index:uint):uint{
			var parts:Array = duration.split(":");
			return uint(parts[index]);
		}
				
		public function getYear(duration:String):uint{
			var parts:Array = duration.split(":");
			return uint(parts[0]);
		}	
		
		public function getMonth(duration:String):uint{
			var parts:Array = duration.split(":");
			return uint(parts[1]);
		}
		
		public function getDay(duration:String):uint{
			var parts:Array = duration.split(":");
			return uint(parts[2]);
		}
		
		public function getHour(duration:String):uint{
			var parts:Array = duration.split(":");
			return uint(parts[3]);
		}
									
		public function getMinute(duration:String):uint{
			var parts:Array = duration.split(":");
			return uint(parts[4]);
		}
		
		public function getSecond(duration:String):uint{
			var parts:Array = duration.split(":");
			return uint(parts[5]);
		}
						
		////////////////////////////////////////////////////	
		

		
		/*
		public function isScaleValuesValid(scales:ArrayCollection):Boolean{
			scales.sort = gu.getSortBySequenceNumber();
			scales.refresh();
			var prevScale:ScaleDTO = null;
			for each (var scale:ScaleDTO in scales){
				if (prevScale != null) {
					if (prevScale.value >= scale.value) return false;
				}
				
				prevScale = scale;
			}
			return true;
		}		
		*/
		
		/*
		public function getMaxSequenceNumber(questions:ArrayCollection):Number{
			var max:Number = 1;
			for each (var question:QuestionDTO in questions){
				if (question.sequenceNumber > max) max = question.sequenceNumber;
			}
			return max;
		}
		*/
		
		/* 		public static function hasContactChooser():Boolean{
		for each (var question:QuestionDTO in Constants.getInstance().questionDTOCollection){
		if (question.type == Constants.QUESTION_TYPE_CONTACT_CHOOSER) return true;
		}
		return false;
		} */
		 
		public function getDefaultChoice(question:QuestionDTO):FieldDTO{
			if (!question.attributes.hasOwnProperty(Constants.DEFAULT_FIELD)){
				return null;
			}
			
			var fieldName:String = question.attributes[Constants.DEFAULT_FIELD];
			var field:FieldDTO = getFieldByName(question, fieldName);
			return field;
		}	
		
		
		public function getDefaultRating(question:QuestionDTO):ScaleDTO{
			if (!question.attributes.hasOwnProperty(Constants.DEFAULT_SCALE)){
				return null;
			}
			
			var scaleName:String = question.attributes[Constants.DEFAULT_SCALE];
			var scale:ScaleDTO = getScaleByName(question, scaleName);
			return scale;
		}		
		
		public function getChoiceLimit(question:QuestionDTO):Number{
			if (!question.attributes.hasOwnProperty(Constants.CHOICE_LIMIT)){
				return -1;
			}
			
			var limit:String = question.attributes[Constants.CHOICE_LIMIT];
			return Number(limit);
		}
		
		public function showSingleChoiceAsList(question:QuestionDTO):Boolean{
			if (!question.attributes.hasOwnProperty(Constants.SHOW_SINGLE_CHOICE_AS_LIST)){
				return false;
			} else return true;			
		}
		
		public function showSelectAll(question:QuestionDTO):Boolean{
			if (!question.attributes.hasOwnProperty(Constants.SHOW_SELECT_ALL)){
				return false;
			} else return true;
		}
				
		public function isExportByColumn(question:QuestionDTO):Boolean{
			if (question.attributes.hasOwnProperty(Constants.EXPORT_BY_COLUMN)){
				return true;
			} else return false;
		}
		
		public function getRowPerHeader(question:QuestionDTO):Number{
			if (!question.attributes.hasOwnProperty(Constants.ROW_PER_HEADER)){
				return 10;
			}
			
			var rowPerHeader:String = question.attributes[Constants.ROW_PER_HEADER];
			return Number(rowPerHeader);
		}	
		
		public function displayRatingAsDropdownList(question:QuestionDTO):Boolean{
			if (question.attributes.hasOwnProperty(Constants.DISPLAY_RATING_AS_DROPDOWN_LIST)) return true;
			else return false;
		}
		
		// for multiple relational choice question type only
		public function isSingleChiocePerLine(question:QuestionDTO):Boolean{
			if (question.attributes.hasOwnProperty(Constants.SINGLE_CHOICE_PER_LINE)) return true;
			else return false;
		}
		
		public function getContactChooser(question:QuestionDTO):QuestionDTO{
			if (!question.attributes.hasOwnProperty(Constants.CC_SHORT_NAME)){
				return null;
			}
			
			var shortName:String = question.attributes[Constants.CC_SHORT_NAME];
			return getQuestionByShortName(model.questions, shortName);
		}	
		
		public function getCCNegate(question:QuestionDTO):Boolean{
			if (!question.attributes.hasOwnProperty(Constants.CC_NEGATE)){
				return false;
			}
			
			var negate:String = question.attributes[Constants.CC_NEGATE];
			if (negate == "1") return true;
			else return false;
		}		

		public function skipOnEmpty(question:QuestionDTO):Boolean{
			if (!question.attributes.hasOwnProperty(Constants.SKIP_ON_EMPTY)){
				return false;
			}
			
			var skip:String = question.attributes[Constants.SKIP_ON_EMPTY];
			if (skip == "1") return true;
			else return false;
		}
		
		public function skipOnInactivity(question:QuestionDTO):Boolean{
			if (!question.attributes.hasOwnProperty(Constants.SKIP_ON_INACTIVITY)){
				return false;
			}
			
			var skip:String = question.attributes[Constants.SKIP_ON_INACTIVITY];
			if (skip == "1") return true;
			else return false;
		}
		
		public function allowUserCreatedNode(question:QuestionDTO):Boolean{
			var attrs:Object = question.attributes;
			if (attrs.hasOwnProperty(Constants.ALLOW_USER_CREATED_NODE) &&
				attrs[Constants.ALLOW_USER_CREATED_NODE] == "Y"){
					return true;
				} else {
					return false;					
				}		
		}
		
		public function hideContactChooserInstruction(question:QuestionDTO):Boolean{
			if (question.attributes.hasOwnProperty(Constants.HIDE_CONTACT_CHOOSER_INSTRUCTION)) return true;
			else return false;
		}
		
		public function getSelectedNodesHeader(question:QuestionDTO):String{
			if (question.type != Constants.QUESTION_TYPE_CONTACT_CHOOSER) return null;
			
			var attrs:Object = question.attributes;
			var header:String;
			if (attrs.hasOwnProperty(Constants.CC_SELECTED_NODES_HEADER)){
				header = attrs[Constants.CC_SELECTED_NODES_HEADER];
			} else {
				header = "";					
			}		
			return header;
		}
						
		public function getNewContactDefaultType(question:QuestionDTO):Object{
			if (!question.attributes.hasOwnProperty(Constants.NEW_CONTACT_DEFAULT_TYPE)){
				return null;
			}
			
			var type:String = question.attributes[Constants.NEW_CONTACT_DEFAULT_TYPE];
			return nu.getNodeTypeDescription(type);
		}
		
		public function getJumpCondition(question:QuestionDTO):FieldDTO{
			if (!question.attributes.hasOwnProperty(Constants.JUMP_CONDITION)){
				return null;
			}
			var fieldName:String = question.attributes[Constants.JUMP_CONDITION];
			return getFieldByName(question, fieldName);
		}
		
		public function getJumpQuestion(question:QuestionDTO):QuestionDTO{
			if (!question.attributes.hasOwnProperty(Constants.JUMP_QUESTION)){
				return null;
			}
			var shortName:String = question.attributes[Constants.JUMP_QUESTION];
			if (shortName == question.shortName){
				logger.warn("jump onto yourself?!");
				return null;
			}
			return getQuestionByShortName(model.questions, shortName);
		}	
		
		public function allowPrint(question:QuestionDTO):Boolean{
			var attrs:Object = question.attributes;
			if (attrs.hasOwnProperty(Constants.ALLOW_PRINT) &&
				attrs[Constants.ALLOW_PRINT] == "1"){
					return true;
				} else {
					return false;					
				}
		}
		
		/*
		public function getSymmetrization(question:QuestionDTO):Object{
			var attrs:Object = question.attributes;
			if (attrs.hasOwnProperty(Constants.SYMMETRIZE)){
				var name:String = attrs[Constants.SYMMETRIZE];
				for each (var o:Object in Constants.SYMMETRIZE_STRATEGIES){
					if (name == String(o.name)) return o;
				}
			}
			
			return null;
		}
		*/
		
		public function getCCEmptyStrategy(question:QuestionDTO):Object{
			var name:String = Constants.CC_EMPTY_NONE; // default
			var attrs:Object = question.attributes;			
			if (attrs.hasOwnProperty(Constants.CC_EMPTY)){
				name = attrs[Constants.CC_EMPTY];
			}
				 
			for each (var o:Object in model.CC_EMPTY_STRATEGIES){
				if (name == String(o.name)) return o;
			}
			
			return null;
		}	
		
		public function getAdvancedDataGridColumnsWidth(question:QuestionDTO):Array{
			var attrs:Object = question.attributes;
			if (attrs.hasOwnProperty(Constants.ADG_COLUMN_WIDTH)){
				var columnWidthString:String = attrs[Constants.ADG_COLUMN_WIDTH];
				return columnWidthString.split(",");
			}
			return null;
		}
		
		public function getAdvancedDataGridColumnFields(question:QuestionDTO):ArrayCollection{
			logger.info("getAdvancedDataGridColumnFields for question: " + question.shortName);
			var attrs:Object = question.attributes;
			var fs:ArrayCollection = new ArrayCollection();
			if (attrs.hasOwnProperty(Constants.ADG_COLUMN_FIELDS)){				
				var s:String = attrs[Constants.ADG_COLUMN_FIELDS];
				//logger.debug("fields: " + s);
				var fields:Array = s.split(",");
				for each (var field:String in fields){
					//logger.debug("field: " + field);
					var parts:Array = field.split("=");
					var f:Object = new Object();
					f.name = parts[0];
					if (parts.length == 2) f.label = parts[1];
					else f.label = parts[0];
					fs.addItem(f);					
				}
			}
			return fs;
		}
		
		public function setAdvancedDataGridColumnFields(question:QuestionDTO, fields:ArrayCollection):void{
			logger.info("setAdvancedDataGridColumnFields for question: " + question.shortName);
			var s:String = "";
			var i:uint = 0;
			for each (var field:Object in fields){
				if (i > 0) s += ",";
				s += (field.name + "=" + field.label);
				i++;
			}
			
			if (s.length == 0){
				delete question.attributes[Constants.ADG_COLUMN_FIELDS];
			} else question.attributes[Constants.ADG_COLUMN_FIELDS] = s;
			
			question.dirty = true;
			
			logger.info("fields: " + s);
		}
		
		public function getAdvancedDataGridColumnSortFields(question:QuestionDTO):ArrayCollection{
			logger.info("getAdvancedDataGridColumnSortFields for question: " + question.shortName);
			var attrs:Object = question.attributes;
			var fs:ArrayCollection = new ArrayCollection();
			if (attrs.hasOwnProperty(Constants.ADG_COLUMN_SORT_FIELDS)){				
				var s:String = attrs[Constants.ADG_COLUMN_SORT_FIELDS];
				logger.debug("sortFields: " + s);
				var sortFields:Array = s.split(",");
				for each (var field:String in sortFields){
					logger.debug("field: " + field);
					var parts:Array = field.split("=");
					var f:Object = new Object();
					f.name = parts[0];
					f.label = parts[1];
					f.caseSensitive = parts[2];
					f.isNumeric = parts[3];
					f.order = parts[4];
					fs.addItem(f);					
				}
			}
			return fs;
		}
		
		public function setAdvancedDataGridColumnSortFields(question:QuestionDTO, sortFields:ArrayCollection):void{
			logger.info("setAdvancedDataGridColumnSortFields for question: " + question.shortName);
			var s:String = "";
			var i:uint = 0;
			for each (var field:Object in sortFields){
				if (i > 0) s += ",";
				s += (field.name + "=" + field.label + "=" + field.caseSensitive + "=" + field.isNumeric + "=" + field.order);
				i++;
			}
			
			if (s.length == 0){
				delete question.attributes[Constants.ADG_COLUMN_SORT_FIELDS];
			} else question.attributes[Constants.ADG_COLUMN_SORT_FIELDS] = s;
			
			question.dirty = true;
			
			logger.info("sortFields: " + s);
		}
		
		public function showImage(question:QuestionDTO):Boolean{
			var attrs:Object = question.attributes;
			if (attrs.hasOwnProperty(Constants.SHOW_IMAGE) &&
				attrs[Constants.SHOW_IMAGE] == "1"){
				return true;
			} else {
				return false;					
			}
		}
		
		public function recordDuration(question:QuestionDTO):Boolean{
			var attrs:Object = question.attributes;
			if (attrs.hasOwnProperty(Constants.RECORD_DURATION) &&
				attrs[Constants.RECORD_DURATION] == "1"){
				return true;
			} else {
				return false;					
			}
		}
		
		/******************* Options ***************************/
		public function isSingleChoice(question:QuestionDTO):Boolean{
			return gu.verify(question.attributes, Constants.OPTION_SINGLE_CHOICE);
			/*
			if (question.options.contains(3)) return true;
			else return false;
			*/
		}		
		
		public function isHidden(question:QuestionDTO):Boolean{
			/*
			for each (var optionId:Number in question.options){
				if (optionId == 1) return true;
			}
			return false;
			*/
			return gu.verify(question.attributes, Constants.OPTION_HIDDEN);
		}
		
		public function useContactsOnly(question:QuestionDTO):Boolean{
			/*
			for each (var optionId:Number in question.options){
				if (optionId == 6) return true;
			}
			return false;
			*/
			return gu.verify(question.attributes, Constants.OPTION_SHOW_USER_CONTACTS_ONLY);
		}
		
		public function showMyself(question:QuestionDTO):Boolean{
			/*
			for each (var optionId:Number in question.options){
				if (optionId == 7) return true;
			}
			return false;
			*/
			return gu.verify(question.attributes, Constants.OPTION_SHOW_SELF);
		}	
		
		public function allowUserCreatedChoice(question:QuestionDTO):Boolean{
			/*
			for each (var optionId:Number in question.options){
				if (optionId == 4) return true;
			}
			return false;
			*/
			return gu.verify(question.attributes, Constants.OPTION_ALLOW_USER_CREATE_CHOICE);
		} 
		
		public function isRelational(question:QuestionDTO):Boolean{
			if (//question.type == Constants.QUESTION_TYPE_TEXT_QUICK ||
				question.type == Constants.QUESTION_TYPE_RELATIONAL_CHOICE ||
				question.type == Constants.QUESTION_TYPE_RELATIONAL_RATING ||
				question.type == Constants.QUESTION_TYPE_RELATIONAL_CONTINUOUS ||
				question.type == Constants.QUESTION_TYPE_RELATIONAL_RATING_MULTIPLE ||
				question.type == Constants.QUESTION_TYPE_RELATIONAL_CHOICE_MULTIPLE ||
				question.type == Constants.QUESTION_TYPE_PERCEIVED_RELATIONAL_RATING||
				question.type == Constants.QUESTION_TYPE_PERCEIVED_RELATIONAL_CHOICE||
				question.type == Constants.QUESTION_TYPE_PERCEIVED_CHOICE||
				question.type == Constants.QUESTION_TYPE_PERCEIVED_RATING) return true;
			else return false;
		}
	}
}