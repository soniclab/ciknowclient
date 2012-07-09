package edu.northwestern.ciknow.common.domain
{
	import mx.collections.ArrayCollection;
		
	[RemoteClass(alias="ciknow.dto.GroupDTO")]	
	[Bindable]
	public class GroupDTO
	{
		[SyncId]
		public var groupId:Number;
		public var version:Number;
		public var name:String;
		//public var nodes:ArrayCollection;

		public function GroupDTO()
		{
			
		}

		public function copyData(group:GroupDTO):void{
			this.groupId = group.groupId;
			this.version = group.version;
			this.name = group.name;
			//this.nodes = group.nodes;
		}
		
		public function isPrivate():Boolean{
			if (name.indexOf("UG_") == 0) return true;
			else return false;
		}
		
		public function isMandatory():Boolean{
			if (name.indexOf("MG_") == 0) return true;
			else return false;
		}		
	}
}