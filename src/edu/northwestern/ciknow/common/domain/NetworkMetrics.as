package edu.northwestern.ciknow.common.domain
{
	import mx.collections.ArrayCollection;
		
	[RemoteClass(alias="ciknow.graph.metrics.NetworkMetrics")]	
	[Bindable]
	public class NetworkMetrics
	{		
		public var networkName:String;
		public var directed:Boolean;
		public var totalNodes:int;
		public var totalEdges:int;
		public var networkDensity:Number;		
		public var networkInDegree:Number;
		public var networkOutDegree:Number;
		public var networkInCloseness:Number;
		public var networkOutCloseness:Number;
		public var networkBetweenness:Number;
		public var networkClusteringCoefficient:Number;
		public var diameter:Number;
		public var characteristicPathLength:Number;
		
		public var inAlpha:Number;
		public var inBeta:Number;
		public var inCounts:ArrayCollection;
		public var outAlpha:Number;
		public var outBeta:Number;
		public var outCounts:ArrayCollection;
		
		public var cliques:ArrayCollection;
		public var connectedComponents:ArrayCollection;
		public var individualMetrics:ArrayCollection;		
	
		public function NetworkMetrics()
		{
			
		}		
	}
}