package edu.northwestern.ciknow.common.domain
{
	import mx.collections.ArrayCollection;

	[RemoteClass(alias="ciknow.graph.metrics.ConnectedComponent")]	
	[Bindable]
	public class ConnectedComponent
	{		
		public var nodes:ArrayCollection;
		public var label:String;
		
		public function ConnectedComponent()
		{
			
		}		
	}
}