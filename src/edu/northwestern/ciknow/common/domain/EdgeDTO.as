package edu.northwestern.ciknow.common.domain
{

	[RemoteClass(alias="ciknow.dto.EdgeDTO")]	
	[Bindable]
	public class EdgeDTO
	{

		public var dirty:Boolean = false;
		
		[SyncId]
		public var edgeId:Number;
		public var version:Number;
		public var creatorId:Number;
		public var fromNodeId:Number;
		public var toNodeId:Number;
		public var type:String;
		public var weight:Number;
		public var directed:Boolean;

		public var attributes:Object = new Object();
		public var longAttributes:Object = new Object();
		
		public function EdgeDTO()
		{
			
		}

		public function copyData(e:EdgeDTO):void{
			edgeId = e.edgeId;
			version = e.version;
			creatorId = e.creatorId;
			fromNodeId = e.fromNodeId;
			toNodeId = e.toNodeId;
			type = e.type;
			weight = e.weight;
			directed = e.directed;
			attributes = e.attributes;
			longAttributes = e.longAttributes;
		}
		
	}
}