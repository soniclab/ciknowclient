package edu.northwestern.ciknow.common.domain
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	[RemoteClass(alias="ciknow.dto.NodeDTO")]	
	[Bindable]
	public class NodeDTO
	{
		public var dirty:Boolean = false;
		
		[SyncId]
		public var nodeId:Number;
		public var version:Number;
		public var label:String;
		public var type:String;
		public var uri:String;

		public var username:String;
		public var password:String;
		public var firstName:String;
		public var lastName:String;
		public var midName:String;
		public var addr1:String;
		public var addr2:String;
		public var city:String;
		public var state:String;
		public var country:String;
		public var zipcode:String;
		public var email:String;
		public var phone:String;
		public var cell:String;
		public var fax:String;
		public var department:String;
		public var organization:String;
		public var unit:String;
		public var enabled:Boolean;

		public var groups:ArrayCollection = new ArrayCollection();
		public var roles:ArrayCollection = new ArrayCollection();
				
		public var attributes:Object = new Object();
		public var longAttributes:Object = new Object();
		
		public function NodeDTO()
		{
			
		}

		public function copyData(n:NodeDTO):void{
			nodeId = n.nodeId;
			version = n.version;
			label = n.label;
			type = n.type;
			uri = n.uri;
			
			username = n.username;
			password = n.password;
			firstName = n.firstName;
			lastName = n.lastName;
			midName = n.midName;
			addr1 = n.addr1;
			addr2 = n.addr2;
			city = n.city;
			state = n.state;
			country = n.country;
			zipcode = n.zipcode;
			email = n.email;
			phone = n.phone;
			cell = n.cell;
			fax = n.fax;
			department = n.department;
			organization = n.organization;
			unit = n.unit;
			enabled = n.enabled;

			groups = n.groups;
			roles = n.roles;
						
			attributes = n.attributes;
			longAttributes = n.longAttributes;
		}	
		
	}
}