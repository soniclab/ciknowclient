package edu.northwestern.ciknow.common.domain
{
	import mx.collections.ArrayCollection;
	

	[RemoteClass(alias="ciknow.dto.VisualizationDTO")]	
	[Bindable]
	public class VisualizationDTO
	{
		public var valid:Boolean = true;
		
		[SyncId]
		public var visId:Number;
		public var version:Number;
		public var creatorId:Number;
		public var name:String;
		public var label:String;
		public var type:String;
		public var networkType:String;
		public var data:String;		
		public var timestamp:Date;
		public var groups:ArrayCollection = new ArrayCollection();
		public var nodes:ArrayCollection = new ArrayCollection();
		public var attributes:Object = new Object();
		
		public function VisualizationDTO()
		{
			
		}
		
	}
}