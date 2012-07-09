package edu.northwestern.ciknow.common.domain
{

	[RemoteClass(alias="ciknow.dto.SurveyDTO")]	
	[Bindable]
	public class SurveyDTO
	{

		[SyncId]
		public var surveyId:Number;
		public var version:Number;
		public var designerId:Number;
		public var name:String;
		public var description:String;
		public var timestamp:Date;
		public var attributes:Object = new Object();
		public var longAttributes:Object = new Object();
		
		public function SurveyDTO()
		{
			
		}

	}
}