package edu.northwestern.ciknow.common.domain
{	
	[RemoteClass(alias="ciknow.graph.metrics.IndividualMetric")]	
	[Bindable]
	public class IndividualMetric
	{					
		public var nodeId:Number;
		public var inDegree:int;
		public var outDegree:int;
		public var inCloseness:Number;
		public var outCloseness:Number;
		public var betweenness:Number;
		public var pageRank:Number;
		public var scanning:Number;
		public var clusteringCoefficient:Number;

		public function IndividualMetric()
		{
			
		}		
		
		public function toString():String{
			return "IndividualMetric[]";
		}
	}
}