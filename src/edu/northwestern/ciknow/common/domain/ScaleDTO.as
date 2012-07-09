package edu.northwestern.ciknow.common.domain
{
	[RemoteClass(alias="ciknow.dto.ScaleDTO")]	
	[Bindable]
	public class ScaleDTO
	{
		public var name:String;
		public var label:String;
		public var value:Number;
		
		public function ScaleDTO()
		{
			
		}
	}
}