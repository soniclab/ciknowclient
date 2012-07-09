package edu.northwestern.ciknow.common.domain
{
	[RemoteClass(alias="ciknow.dto.TextFieldDTO")]	
	[Bindable]
	public class TextFieldDTO
	{
		public var name:String;
		public var large:Boolean;
		public var label:String;

		public function TextFieldDTO()
		{
			
		}

	}
}