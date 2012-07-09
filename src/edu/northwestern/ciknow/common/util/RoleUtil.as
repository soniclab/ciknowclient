package edu.northwestern.ciknow.common.util
{
	
	import edu.northwestern.ciknow.common.domain.RoleDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class RoleUtil
	{
		private static var logger:ILogger = LogUtil.getLog(RoleUtil);
		
		[Inject]
		public var model:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function RoleUtil()
		{
		}

		public function getRoleById(id:Number):RoleDTO{
			for each (var g:RoleDTO in model.roles){
				if (g.roleId == id) return g;
			}
			return null;
		}
		
		public function getRoleByName(name:String):RoleDTO{
			for each (var g:RoleDTO in model.roles){
				if (g.name == name) return g;
			}
			return null;
		}	
		
		public function validateNewRoleName(name:String):Boolean{
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
			
			if (isRoleNameFreezed(name)){
				Alert.show("System role name: " + name + " is reserved.", "ERROR");				
				return false;
			} 
			
			for each (var r:RoleDTO in model.roles){
				if (r.name == name){
					Alert.show("Role name: " + name + " has already been used.", "ERROR");
					return false;
				}
			}
			
			return true;
		}		
		
		public function isRoleNameFreezed(name:String):Boolean{
			if (name == Constants.ROLE_ADMIN) return true;
			if (name == Constants.ROLE_HIDDEN) return true;
			if (name == Constants.ROLE_USER) return true;
			return false;
		}	
	}
}