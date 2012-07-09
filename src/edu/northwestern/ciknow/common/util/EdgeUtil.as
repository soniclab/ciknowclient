package edu.northwestern.ciknow.common.util
{	
	import edu.northwestern.ciknow.common.domain.EdgeDTO;
	import edu.northwestern.ciknow.common.domain.FieldDTO;
	import edu.northwestern.ciknow.common.domain.NodeDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	
	public class EdgeUtil
	{		
		private var logger:ILogger = LogUtil.getLog(EdgeUtil);
	
		[Inject]
		public var sm:SharedModel;
		
		[Inject]
		public var nu:NodeUtil;
		
		public function EdgeUtil()
		{
		}
		
		
/*		public function viewEdgeHtml(fromNodeId:Number, toNodeId:Number, type:String):void{
			var url:String = sm.baseURL + 
							"/vis_get_link_info.jsp?from=" + fromNodeId +
							"&to=" + toNodeId +
							"&type=" + type;
			flash.net.navigateToURL(new URLRequest(url), "_blank");
		}					
		
		public function getEdgeById(edges:ArrayCollection, id:Number):EdgeDTO{
			for each (var edge:EdgeDTO in edges){
				if (edge.edgeId == id) return edge;
			}
			return null;			
		}	
				
		public function removeEdgeById(edges:ArrayCollection, id:Number):void{	
			if (edges == null || edges.length == 0) return;
				
			var i:Number = 0;
			for each(var edge:EdgeDTO in edges){
				if (edge.edgeId == id) break;
				i++;
			}
			if (i < edges.length) edges.removeItemAt(i);
		}
		

 		public function updateEdge(edges:ArrayCollection, e:EdgeDTO):void{
			var edge:EdgeDTO = getEdgeById(edges, e.edgeId);
			if (edge != null) edge.copyData(e);
		} 	
		*/		

	

		/*
		public function saveQuestionEdge(edge:EdgeDTO, question:QuestionDTO):void{
			if (edge == null) {
				logger.warn("null input");
				return;
			}
			var edges:ArrayCollection = new ArrayCollection();
			edges.addItem(edge);
			saveQuestionEdges(edges, question);			
		}
				
		public function saveQuestionEdges(edges:ArrayCollection, question:QuestionDTO):void{
			if (edges == null || edges.length == 0){
				logger.warn("empty input");
				return;
			}			
			var edgeEvent:EdgeDTOEvent = new EdgeDTOEvent(EdgeDTOEvent.SAVE_QUESTION_EDGE);
			edgeEvent.data = new Object();
			edgeEvent.data.edges = edges;
			edgeEvent.data.qid = question.questionId.toString();
			edgeEvent.dispatch();			
		}
		
		public function deleteQuestionEdge(edge:EdgeDTO, question:QuestionDTO):void{
			if (edge == null) {
				logger.warn("null input");
				return;
			}
			var edges:ArrayCollection = new ArrayCollection();
			edges.addItem(edge);
			deleteQuestionEdges(edges, question);			
		}
				
		public function deleteQuestionEdges(edges:ArrayCollection, question:QuestionDTO):void{
			if (edges == null || edges.length == 0){
				logger.warn("empty input");
				return;
			}
			var edgeEvent:EdgeDTOEvent = new EdgeDTOEvent(EdgeDTOEvent.DELETE_QUESTION_EDGE);
			edgeEvent.data = new Object();
			edgeEvent.data.edges = edges;
			edgeEvent.data.qid = question.questionId.toString();
			edgeEvent.dispatch();			
		}		
		
		/////////////////////////// TAGGING //////////////////////////////////////
					
  		public function createNodeTagging(creatorId:Number, fromNodeId:Number, toNodeId:Number):EdgeDTO{
			var nodeTagging:EdgeDTO = new EdgeDTO();
			nodeTagging.creatorId = creatorId;
			nodeTagging.fromNodeId = fromNodeId;
			nodeTagging.toNodeId = toNodeId;
			nodeTagging.type = ModelLocator.TAGGING_PREFIX + "node";
			nodeTagging.directed = true;
			nodeTagging.weight = 1;			
			return nodeTagging;		
		}  
				
 		public function getNodeTagging(taggings:ArrayCollection, creatorId:Number, 
									fromNodeId:Number, toNodeId:Number):EdgeDTO{
			for each (var tagging:EdgeDTO in taggings){
				if (tagging.creatorId == creatorId &&
					tagging.fromNodeId == fromNodeId &&
					tagging.toNodeId == toNodeId &&
					tagging.type == ModelLocator.TAGGING_PREFIX + "node"){
						return tagging;
					}
			}							
			return null;
		} 
		*/
		
		///////// edge descriptions (type, label, verb, etc...) ////////////////
		public function getEdgeTypes(eds:Vector.<Object>):ArrayCollection{
			var edgeTypes:ArrayCollection = new ArrayCollection();
			for each (var ed:Object in eds){
				var edgeType:String = String(ed.type);
				edgeTypes.addItem(edgeType);
			} 
			
			return edgeTypes;
		}
		
		public function getEdgeDescription(eds:ArrayCollection, edgeType:String):Object{
			for each (var ed:Object in eds){
				if (ed.type == edgeType) return ed;
			}
			return null;
		}	
		
		public function getEdgeLabel(eds:ArrayCollection, edgeType:String):String{
			for each (var ed:Object in eds){
				if (ed.type == edgeType) return String(ed.label);
			}
			return null;
		}		
		
		public function getEdgeVerb(eds:ArrayCollection, edgeType:String):String{
			for each (var ed:Object in eds){
				if (ed.type == edgeType) return String(ed.verb);
			}
			return null;
		}
		
	}
}