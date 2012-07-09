package edu.northwestern.ciknow.common.domain
{
	
	import mx.collections.ArrayCollection;

	[RemoteClass(alias="ciknow.dto.QuestionDTO")]	
	[Bindable]
	public class QuestionDTO
	{

		public var dirty:Boolean = false;

		[SyncId]
		public var questionId:Number;
		public var version:Number;
		public var pageId:Number;
		public var label:String;
		public var shortName:String;
		public var type:String;
		public var instruction:String;
		public var htmlInstruction:String;
		public var rowPerPage:int;
		public var attributes:Object = new Object();
		public var longAttributes:Object = new Object();
		
		public var fields:ArrayCollection = new ArrayCollection();
		public var scales:ArrayCollection = new ArrayCollection();
		public var textFields:ArrayCollection = new ArrayCollection();
		public var contactFields:ArrayCollection = new ArrayCollection();
		
		public var visibleGroups:ArrayCollection = new ArrayCollection();
		public var availableGroups:ArrayCollection = new ArrayCollection();
		public var availableGroups2:ArrayCollection = new ArrayCollection();
		
		public function QuestionDTO()
		{
			
		}
	}
}