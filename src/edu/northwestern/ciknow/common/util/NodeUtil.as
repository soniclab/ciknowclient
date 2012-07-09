package edu.northwestern.ciknow.common.util
{
	import edu.northwestern.ciknow.common.domain.*;
	
	import flash.net.*;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class NodeUtil
	{
		private static const logger:ILogger = LogUtil.getLog(NodeUtil);
		
		[Inject]
		public var sm:SharedModel;
		[Inject]
		public var gu:GeneralUtil;
		[Inject]
		public var qu:QuestionUtil;
		
		public function initPlainNodes(nodes:ArrayCollection):void{
			var nodeMap:Object = new Object();
			var allUsernames:ArrayCollection = new ArrayCollection();
			var allNodeLabels:ArrayCollection = new ArrayCollection();			
			for each (var node:Object in nodes){
				nodeMap[String(node.nodeId)] = node;
				allUsernames.addItem(String(node.username));
				allNodeLabels.addItem(String(node.label));
			}
			sm.nodeMap = nodeMap;
			sm.allNodeLabels = allNodeLabels;
			sm.allUsernames = allUsernames;
		}
		
		/////////////////// query //////////////////////////////////
		public function getNodeById(id:Number):Object{			
			if (sm.nodeMap.hasOwnProperty(id.toString())) {
				return sm.nodeMap[id.toString()];
			}
			
			return null;
		}
		
		public function getNodeFromCollectionById(nodes:IList, nodeId:Number):NodeDTO{
			for each (var n:NodeDTO in nodes){
				if (n.nodeId == nodeId) return n;
			}
			return null;
		}
		
		public function getNodeFromCollectionByLabel(nodes:IList, nodeLabel:String):NodeDTO{
			for each (var n:NodeDTO in nodes){
				if (n.label == nodeLabel) return n;
			}
			return null;
		}
		
		public function getNodeByUsername(username:String):Object{
			for each (var node:Object in sm.nodeMap){
				if (node.username == username) return node;
			}
			return null;
		}
		
		public function getNodeByLabel(label:String):Object{
			for each (var node:Object in sm.nodeMap){
				if (node.label == label) return node;
			}
			return null;
		}		

		
		/////////////////// general ////////////////////////////////// 
		public function isAdmin(node:NodeDTO):Boolean{
			for each (var roleId:Number in node.roles){
				if (roleId == 1) return true;
			}
			return false;
		}
		
		/**
		 * It is too costly to obtain a full node in order to determine
		 * whether a node is hidden or not.
		 * Since this method is only used in survey module, it is move into surveyPM.as
		public function isHidden(node:NodeDTO):Boolean{
			for each (var roleId:Number in node.roles){
				if (roleId == 2) return true;
			}
			return false;
		}
		*/		
		
		public function isUsernameValid(username:String):Boolean{
			if (username == ''){
				Alert.show("Username cannot be empty.");
				return false;
			}
			
			if (username.length > 50) {
				Alert.show("Username is too long (>50): " + username);
				return false;
			}
			
			if (gu.hasInvalidChar(username)
				|| username.indexOf(",") >= 0
				|| username.indexOf("`") >= 0
				|| username.indexOf(" ") >= 0){
				Alert.show("Username cannot contain special characters: < > / \\ \" ? : | * , ` or space: " + username);
				return false; 
			}
			
			return true;
		}
		
		public function getAddress(node:NodeDTO):String{			
			var address:String = "";
			if (node.addr1 != null && node.addr1.length > 0) address = node.addr1;
			if (node.addr2 != null && node.addr2.length > 0) {
				if (address.length > 0) address += ", ";
				address += node.addr2;
			} 
			if (node.city != null && node.city.length > 0) {
				if (address.length > 0) address += ", ";
				address += node.city;
			}
			if (node.state != null && node.state.length > 0) {
				if (address.length > 0) address += ", ";
				address += node.state;
			}
			if (node.zipcode != null && node.zipcode.length > 0) {
				if (address.length > 0) address += ", ";
				address += node.zipcode;
			}
			if (node.country != null && node.country.length > 0) {
				if (address.length > 0) address += ", ";
				address += node.country;
			}		
			
			return address;				
		}	
		
		public function getAttributeValue(node:NodeDTO, attrName:String):String{
			if (node.attributes.hasOwnProperty(attrName)){
				return node.attributes[attrName];
			}
			return null;		
		}
		
		public function getLongAttributeValue(node:NodeDTO, attrName:String):String{
			if (node.longAttributes.hasOwnProperty(attrName)){
				return node.longAttributes[attrName];
			}
			return null;		
		}			
		
		public function viewNodeHtml(nodeId:Number):void{
			var url:String = sm.baseURL + "/vis_get_node_info.jsp?node=" + nodeId;
			navigateToURL(new URLRequest(url), "_blank");
		}
		
		public function getNodeTypeDescription(type:String):Object{
			for each (var ntd:Object in sm.nodeTypeDescriptions){
				if (String(ntd.type) == type) return ntd; 
			}
			return null;
		}
		
		public function getNodeTypes(ntds:Vector.<Object>):ArrayCollection{
			var nodeTypes:ArrayCollection = new ArrayCollection();
			for each (var ntd:Object in ntds){
				nodeTypes.addItem(String(ntd.type));
			}
			return nodeTypes;
		}
		
		public function getColorableProperty(name:String):Object{
			for each (var p:Object in sm.COLORABLE_PROPERTIES){
				if (p.name == name) return p;
			}
			return null;
		}
	}
}