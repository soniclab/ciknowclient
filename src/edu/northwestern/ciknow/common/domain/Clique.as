package edu.northwestern.ciknow.common.domain
{
	import mx.collections.ArrayCollection;
		
	[RemoteClass(alias="ciknow.graph.metrics.Clique")]	
	[Bindable]
	public class Clique
	{		
		public var nodes:ArrayCollection;
		public var label:String;
		
		public function Clique()
		{
			
		}		
	}
}