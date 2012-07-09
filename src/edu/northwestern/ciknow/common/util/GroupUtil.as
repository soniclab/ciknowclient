package edu.northwestern.ciknow.common.util
{
	
	import edu.northwestern.ciknow.common.domain.GroupDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class GroupUtil
	{
		private static var logger:ILogger = LogUtil.getLog(GroupUtil);
		
		[Inject]
		public var model:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function GroupUtil()
		{
		}

		public function getGroupById(id:Number):GroupDTO{
			for each (var g:GroupDTO in model.groups){
				if (g.groupId == id) return g;
			}
			return null;
		}
		
		public function getGroupByName(name:String):GroupDTO{
			for each (var g:GroupDTO in model.groups){
				if (g.name == name) return g;
			}
			return null;
		}		
		
 		public function getPrivateGroupName(username:String, shortName:String):String{
			return "UG_" + username + "_" + shortName;
		} 
				
		public function getGroupNameByNodeType(type:String):String{
			var typeGroupName:String;
			if (type == Constants.NODE_TYPE_USER){
				typeGroupName = Constants.GROUP_USER;
			} else {
				typeGroupName = Constants.GROUP_NODE_TYPE_PREFIX + type;
			}
			return typeGroupName;
		}
		
		public function getMaxGroupId():Number{
			var max:Number = 0;
			for each (var g:GroupDTO in model.groups){
				if (g.groupId > max) max = g.groupId;
			}	
			return max;
		}		
			
		public function validateNewGroupName(name:String):Boolean{
			if (name == null || name.length == 0){
				Alert.show("Name cannot be empty.");
				return false;
			}
			
			if (name.length > 250){
				Alert.show("Name is too long (>250): " + name);
				return false;
			}
			
			if (gu.hasInvalidChar(name)
				|| name.indexOf(",") >= 0
				|| name.indexOf("`") >= 0
				|| name.indexOf(" ") >= 0){
				Alert.show("Name cannot contain special characters: < > / \\ \" ? : | * , ` or space: " + name);
				return false; 
			}
			
			if (isGroupNameFreezed(name)){
				Alert.show("System group name: " + name + " is reserved.", "ERROR");				
				return false;
			} 

			for each (var g:GroupDTO in model.groups){
				if (g.name == name){
					Alert.show("Group name: " + name + " has already been used.", "ERROR");
					return false;
				}
			}
			
			return true;
		}		
		
		public function isGroupNameFreezed(name:String):Boolean{
			if (name == Constants.GROUP_ALL) return true;
			if (name == Constants.GROUP_USER) return true;
			if (name.indexOf("UG_") == 0) return true;			
			if (name.indexOf(Constants.GROUP_NODE_TYPE_PREFIX) >= 0) return true;
			if (name.indexOf(Constants.GROUP_DEPT_PREFIX) >= 0) return true;
			if (name.indexOf(Constants.GROUP_ORGANIZATION_PREFIX) >= 0) return true;
			if (name.indexOf(Constants.GROUP_UNIT_PREFIX) >= 0) return true;
			return false;
		}		
		
		
		/////////////// node is new, map is obsolete //////////////////////
		/*
		public function addNode(node:NodeDTO):void{			
			for each (var groupId:Number in node.groups){
				var nodes:ArrayCollection = model.groupMap[groupId];
				if (nodes == null){
					nodes = new ArrayCollection();
					model.groupMap[groupId] = nodes;
					Alert.show("New group has been created in remote server. Refresh browser in order to be in sync.");
				}
				nodes.addItem(node.nodeId);
				logger.debug("node " + node.username + " is added to group (id=" + groupId + ")");
			}		
		}
		
		public function updateNode(node:NodeDTO):void{
			var nodeId:Number = node.nodeId;
			for (var groupId:String in model.groupMap){
				var nodes:ArrayCollection = model.groupMap[groupId];
				var index:Number = nodes.getItemIndex(nodeId);
				if (index != -1 && !node.groups.contains(Number(groupId))) {
					nodes.removeItemAt(index);
					logger.debug("node (id=" + nodeId + ") is removed from group (id=" + groupId + ")");
				} else if (index == -1 && node.groups.contains(Number(groupId))){
					nodes.addItem(nodeId);
					logger.debug("node " + node.username + " is added to group (id=" + groupId + ")");
				}
			}			
		}
		
		public function removeNode(nodeId:Number):void{
			for (var groupId:String in model.groupMap){
				var nodes:ArrayCollection = model.groupMap[groupId];
				var index:Number = nodes.getItemIndex(nodeId);
				if (index != -1) {
					nodes.removeItemAt(index);
					logger.debug("node (id=" + nodeId + ") is removed from group (id=" + groupId + ")");
				}
			}			
		}
		*/		
	}
}