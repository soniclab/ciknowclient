package edu.northwestern.ciknow.common.util
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	
	import edu.northwestern.ciknow.common.domain.NodeDTO;
	import edu.northwestern.ciknow.common.domain.QuestionDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.domain.SurveyDTO;
	import edu.northwestern.ciknow.common.events.GeneralEvent;
	import edu.northwestern.ciknow.common.events.RecommendationEvent;
	import edu.northwestern.ciknow.common.l10n.views.assets.LocaleAssets;
	
	import flash.display.DisplayObject;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.net.*;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.logging.ILogger;
	import mx.managers.PopUpManager;
	import mx.rpc.Fault;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	
	public class GeneralUtil
	{
		public static const EXCEPTION:String = "java.lang.Exception";
		public static const SERVLET_EXCEPTION:String = "javax.servlet.ServletException";
		public static const DATA_INTEGRITY:String = "org.springframework.dao.DataIntegrityViolationException";
		public static const OPTIMISTIC_LOCK:String = "org.springframework.orm.hibernate3.HibernateOptimisticLockingFailureException";
		public static const CHANNEL_DISCONNECTED:String = "Channel disconnected";
		public static const SEND_FAILED:String = "Send failed";
		
		private static const logger:ILogger = LogUtil.getLog(GeneralUtil);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject]
		public var model:SharedModel;
		
		[Inject(id="groupCache")]
		public var groupCache:IDataCache;
		
		[Inject(id="roleCache")]
		public var roleCache:IDataCache;
		
		[Inject(id="surveyCache")]
		public var surveyCache:IDataCache;
		
		[Inject(id="questionCache")]
		public var questionCache:IDataCache;
		
		public function show(c:UIComponent):void{				
			c.visible = true;
			c.includeInLayout = true;
		}
		
		public function hide(c:UIComponent):void{
			c.visible = false;
			c.includeInLayout = false;
		}
					
		
		public function copyArrayCollection(a:ArrayCollection):ArrayCollection{
			var b:ArrayCollection = new ArrayCollection();
			for each (var o:Object in a){
				b.addItem(o);
			}
			return b;
		}
		
		
		/*******************************************
		 * XML processing
		 * *****************************************/
		public function removeXMLChildren(xml:XML):void{
			var length:int = xml.children().length();

			for (var i:int = length - 1; i >= 0; i--){
				delete xml.children()[i];
			}
		}
		
		/****************************************************
		 * Character handling, escape
		 * **************************************************/		
 		public function hasInvalidChar(s:String):Boolean{
			// these characters cannot exist in file/directory names
			if (s.indexOf("/") >= 0) return true;
			if (s.indexOf("\\") >= 0) return true;
			if (s.indexOf("*") >= 0) return true;
			if (s.indexOf("\"") >= 0) return true;
			if (s.indexOf("<") >= 0) return true;
			if (s.indexOf(">") >= 0) return true;
			if (s.indexOf(":") >= 0) return true;
			if (s.indexOf("|") >= 0) return true;
			if (s.indexOf("?") >= 0) return true;
			
			// This seperator is used in contructing edgeType
			if (s.indexOf(Constants.SEPERATOR) >= 0) return true;
			
			return false;
		} 
		
		public function capitalizeInitialChar(input:String):String{
			var head:String = input.substr(0, 1);
			var tail:String = input.substr(1);
			return head.toUpperCase() + tail;			
		}
		
		/**
		 * The ActionScript escape method has limitation, which does not encode certain reserved characters.
		 * Here is the rescue. Look for example in SearchNetwork.mxml
		 **/
		public function escapeMore(s:String):String{	
			var pattern:RegExp = new RegExp("[+]", "g");	// + is a metacharacter, use [] to make it character class			
			s = s.replace(pattern, "%2B");
			
			pattern = new RegExp("[/]", "g");
			s = s.replace(pattern, "%2F");
			
			pattern = new RegExp("@", "g");
			s = s.replace(pattern, "%40");
			return s;			
		}
		
		public function measureString(str:String, format:TextFormat = null):Rectangle{
			if (format == null) {
				format = new TextFormat();
				format.font = "Arial";
				format.size = 12;
			}
			
			var textField:TextField = new TextField();
			textField.defaultTextFormat = format;
			textField.text = str;
			
			return new Rectangle(0, 0, textField.textWidth, textField.textHeight);
		}
		
		/****************************************************************
		 * Filters for graph extraction
		 * *************************************************************/
		public function getFilters(filterConditions:ArrayCollection):ArrayCollection{
			logger.debug("get filters...");
			var filters:ArrayCollection = new ArrayCollection();				
			for each (var c:Object in filterConditions){
				var fc:String = "";
				/*
				fc += escape(c.name.name) + "-.-";
				fc += escape(c.operator.name) + "-.-";
				fc += escape(c.value.value);					
				filters.addItem(escape(fc));
				*/
				fc += c.name.name + "-.-";
				fc += c.operator.name + "-.-";
				fc += c.value.value;					
				filters.addItem(fc);					
				//logger.debug("filter: " + fc);
			}
			return filters;
		}
		
		/**********************************************
		 * Error handler
		 * ********************************************/
		public function handleFault(fault:Fault):void{
			logger.debug(fault.toString());		
			
			var msg:String = "";
			if (fault.faultString.indexOf(EXCEPTION) == 0){
				msg = fault.faultString.substr(EXCEPTION.length + 3);
			} else if (fault.faultString.indexOf(SERVLET_EXCEPTION) == 0){
				msg = fault.faultString.substr(SERVLET_EXCEPTION.length + 3);
			} else if (fault.faultString == CHANNEL_DISCONNECTED){
				msg = "Session is timeout, please refresh.";
				Alert.yesLabel = "Refresh";
				Alert.show(msg, "Session Expired", Alert.YES, null, refreshHandler, null, Alert.YES);
				Alert.yesLabel = "Yes";
				return;
			} else if (fault.faultString == SEND_FAILED){
				msg = "Version is outdated, please refresh. \nIf problem persist, please relogin.";
				Alert.yesLabel = "Refresh";
				Alert.noLabel = "Logout";
				Alert.show(msg, "Version Outdated", Alert.YES|Alert.NO, null, sendFailedHandler, null, Alert.YES);
				Alert.yesLabel = "Yes";
				Alert.noLabel = "No";
				return;
			} else {
				msg = fault.faultString;
			}
						
			Alert.show(msg, "ERROR");			
		}
		
		private function refreshHandler(e:CloseEvent):void{
			if (e.detail == Alert.YES) refresh();
		}
		
		private function sendFailedHandler(e:CloseEvent):void{
			if (e.detail == Alert.YES) {
				refresh();
			} else {
				logout();
			}
		}				
		
		public function refresh():void
		{
			//var url:URLRequest = new URLRequest("javascript:location.reload(true)");
			var url:URLRequest = new URLRequest(model.baseURL + "/index.html?c=" + Math.random());
			navigateToURL(url, "_self");
		}
		
		public function logout():void{				
			Alert.show("Are you sure to exit?", "", Alert.YES|Alert.NO, null, logoutHandler);
		}
		
		private function logoutHandler(event:CloseEvent):void{
			if (event.detail == Alert.YES){
				var url:String = model.baseURL;
				if (!model.authenticated) {				
					url += "/index.jsp?logout=1";
				} else {
					url += "/j_spring_security_logout";
				}
				var logoutUrl:URLRequest = new URLRequest(url);		
				navigateToURL(logoutUrl, "_self");
			}
		}
		
		/*******************************************************
		 * SORT related
		 * *****************************************************/
		public function getSort(attribute:String, descendingBoolean:Boolean=false, numericObject:Object=false):Sort{
			var s:Sort = new Sort();
			s.fields = [new SortField(attribute, descendingBoolean, numericObject)];
			return s;
		}
		
		public function getSpecialNodeLabelSort():Sort{
			var s:Sort = new Sort();
			s.compareFunction = SpecialNodeLabelCompare;
			return s;
		}			
		
		private function SpecialNodeLabelCompare(a:Object, b:Object, fields:Array = null):int{
			var sa:String = String(a.label);
			var sb:String = String(b.label);
			var indexa:int = sa.indexOf("_");
			var indexb:int = sb.indexOf("_");
			if (indexa != 0 && indexb != 0) return sa.localeCompare(sb);
			else if (indexa == 0 && indexb == 0) return sa.localeCompare(sb);
			else if (indexa == 0) return 1;
			else if (indexb == 0) return -1;
			else return 0;				
		}
		
		public function getNodeIdStringSort():Sort{
			var s:Sort = new Sort();
			s.compareFunction = nodeIdStringCompare;
			return s;
		}
		
		private function nodeIdStringCompare(a:Object, b:Object, fields:Array = null):int{
			var na:Number = Number(a.nodeId);
			var nb:Number = Number(b.nodeId);
			if (na < nb) return -1;
			else if (na==nb) return 0;
			else return 1;
		}	
		
		
		/*****************************************
		 * get parameters from URL
		 * ***************************************/
		public function getParams():Object{
			if (!ExternalInterface.available){
				Alert.show("Incompatible browser!");
				return null;
			}
			var	url:String = ExternalInterface.call("document.URL.toString");				
			logger.info("url: " + url);
			
			var params:Object = new Object();
			var pIndex:Number = url.indexOf("?");
			if (pIndex > 0){
				var pString:String = url.substr(pIndex+1);
				logger.info("parameters: " + pString);
				var items:Array = pString.split("&");
				for each (var item:String in items){
					var parts:Array = item.split("=");
					var name:String = parts[0];
					var value:String = parts[1];
					params[name] = value;
					logger.info("name=" + name + ", value=" + value);
				}
			}
			return params;
		}
		
		/******************************************************
		 * Node/Edge/Survey/Question/etc attributes processing
		 * ****************************************************/
		// true if attributes contain the key and (value="1" or value="Y")
		public function verify(attributes:Object, key:String):Boolean{
			if (attributes.hasOwnProperty(key)){
				var value:String = attributes[key];
				if (value=="Y" || value=="1") return true;
			}
			return false;
		}
		
		public function getAttributeValue(attributes:Object, attrName:String):String{
			if (attributes.hasOwnProperty(attrName)){
				return attributes[attrName];
			}
			return null;		
		}
		
		public function getDefaultLocale(attributes:Object):Object{
			var locale:String = getAttributeValue(attributes, Constants.SURVEY_DEFAULT_LOCALE);
			if (locale == null) locale = "en_US";
			for each (var o:Object in LocaleAssets._locales){
				if (o.locale == locale) return o;
			}
			return null;
		}
		
		
		
		/******************************************************
		 * url navigation
		 * ****************************************************/
		public function viewCodebook():void{
			flash.net.navigateToURL(new URLRequest(model.baseURL + "/codebook.jsp"));
		}
		
		public function viewNodeAttributesSample():void{
			flash.net.navigateToURL(new URLRequest(model.baseURL + "/html/nodeAttributes.sample.txt"));
		} 
		
		/******************************************************
		 * cron job
		 * ****************************************************/
		public function getSchduleByName(name:String):Object{
			for each (var o:Object in model.JOB_SCHEDULES){
				if (name == o.name) return o;
			}
			return null;
		}
		
		/******************************************************
		 * messaging
		 * ****************************************************/	
		public function getMessageLabelByType(type:Number):String{
			for each(var item:Object in model.MSG_TYPES){
				if (Number(item.value) == type) return String(item.label);
			} 
			return "UNKNOWN";
		}
		
		/******************************************************
		 * visualization
		 * ****************************************************/	
		public function colorToHex(color:uint):String{
			var hex:String = (color & 0x00FFFFFF).toString(16).toUpperCase();
			var sb:String = "0x";
			for (var i:int = 0; i < 6-hex.length; i++){
				sb += "0";
			}
			sb += hex;
			
			return sb;			
		}
		
		public function getURL(networkType:String, networkUrl:String, visualSettingsUrl:String):String{
			var url:String = model.baseURL;
			url += ("/vis?networkType=" + networkType);
			url += networkUrl;
			url += visualSettingsUrl;
			var os:String = Capabilities.os.substr(0, 3);
			url += ("&os=" + os);
			
			logger.debug(url);
			
			return url;
		}
		
		/******************************************************
		 * popup
		 * ****************************************************/
		public function showPopup(p:IFlexDisplayObject, moduleFactory:IFlexModuleFactory=null):void{
			PopUpManager.addPopUp(p, DisplayObject(FlexGlobals.topLevelApplication), true, null, moduleFactory);
		}

		
		/***************************** *******************************/
		public function initApp(data:Object):void{
			var baseURL:String = data.hasOwnProperty("baseURL")?data.baseURL:"";
			logger.debug("Server baseURL: " + baseURL);
			// get baseURL from BrowserManager during application initialization in index.mxml
			//model.baseURL = baseURL; 							

			model.loginNode = NodeDTO(data.loginNode);
			logger.debug("loginNode: " + model.loginNode.username);
			var s:String = String(data.authenticated);
			if (s == "1") {
				model.authenticated = true;
			}
			else {
				model.authenticated = false;
			}
			
			/*
			var nodes:ArrayCollection = ArrayCollection(nodeCache.synchronize(IList(data.nodes)));
			model.nodes = nodes;
			logger.debug("received " + nodes.length + " nodes");
			*/
			
			surveyCache.clear();
			var surveyList:IList = IList(data.surveys);
			var surveys:ArrayCollection = ArrayCollection(surveyCache.synchronize(surveyList));
			logger.debug("received " + surveys.length + " surveys.");				
			model.surveys = surveys;
			model.currentSurvey = surveys.getItemAt(0) as SurveyDTO;
			
			questionCache.clear();
			var questionList:IList = IList(data.questions);
			var questions:ArrayCollection = ArrayCollection(questionCache.synchronize(questionList));
			logger.debug("received " + questions.length + " questions for current survey.");
			model.questions = questions;
			
			logger.debug("received all groups ...");
			groupCache.clear();
			model.groups = ArrayCollection(groupCache.synchronize(IList(data.groups)));
			model.groups.sort = getSort("name");
			model.groups.refresh();
			logger.debug("received all roles ...");
			roleCache.clear();
			model.roles = ArrayCollection(roleCache.synchronize(IList(data.roles)));
			model.roles.sort = getSort("name");
			model.roles.refresh();
			
			logger.debug("received node and edge type descriptions...");
			model.nodeTypeDescriptions = ArrayCollection(data.nodeTypeDescriptions);
			model.nodeTypeDescriptions.sort = getSort("label");
			model.nodeTypeDescriptions.refresh();
			
			model.edgeTypeDescriptions = ArrayCollection(data.edgeTypeDescriptions);
			model.edgeTypeDescriptions.sort = getSort("label");
			model.edgeTypeDescriptions.refresh();
		}
	}
}