package edu.northwestern.ciknow.common.domain
{
	[RemoteClass(alias="ciknow.dto.JobDTO")]	
	[Bindable]
	public class JobDTO
	{
		public var name:String;
		public var type:String;
		public var creator:String;
		public var scheduledRuntime:String; // daily, weekly, monthly, etc
		public var description:String;
		/*
		public String beanName; // spring bean name
		public String className;
		public String methodName;
		public byte[] parameterTypes;
		public byte[] parameterValues;
		*/
		
		public var enabled:Boolean = true;
		public var createTS:Date = new Date();
		public var lastRunTS:Date = new Date();
		
		public function JobDTO()
		{
		}
	}
}