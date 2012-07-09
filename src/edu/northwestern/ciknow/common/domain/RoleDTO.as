package edu.northwestern.ciknow.common.domain
{
	import mx.collections.ArrayCollection;

	[RemoteClass(alias="ciknow.dto.RoleDTO")]	
	[Bindable]
	public class RoleDTO
	{
		[SyncId]
		public var roleId:Number;
		public var version:Number;
		public var name:String;
		//public var nodes:ArrayCollection;

		public function RoleDTO()
		{
			
		}

		public function copyData(role:RoleDTO):void{
			this.roleId = role.roleId;
			this.version = role.version;
			this.name = role.name;
			//this.nodes = role.nodes;
		}
		
	}
}