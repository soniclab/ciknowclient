package edu.northwestern.ciknow.common.domain
{

	[RemoteClass(alias="ciknow.dto.ContactFieldDTO")]	
	[Bindable]
	public class ContactFieldDTO
	{
		public var name:String;
		public var label:String;


		public function ContactFieldDTO()
		{
			
		}		
	}
}