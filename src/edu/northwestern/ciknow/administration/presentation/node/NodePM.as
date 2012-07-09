package edu.northwestern.ciknow.administration.presentation.node
{
	import com.adobe.cairngorm.integration.data.DataCache;
	
	import edu.northwestern.ciknow.common.domain.NodeDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.NodeEvent;
	import edu.northwestern.ciknow.common.util.Constants;
	import edu.northwestern.ciknow.common.util.LogUtil;
	import edu.northwestern.ciknow.common.util.NodeUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.Sort;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.utils.StringUtil;
	import mx.validators.Validator;

	public class NodePM
	{
		public function NodePM()
		{
		}
		
		
		public var NULL:Object = {type:"----", label:"----"};
		/*		private static const FIRST_NAME:String = "firstName";
		private static const LAST_NAME:String = "lastName";
		public static const CREATE_NODE:String = "createNode";
		public static const UPDATE_NODE:String = "updateNode";
		private static const VIEW_TYPE_SELECT:String = "select";
		private static const VIEW_TYPE_SEARCH:String = "search";*/
		
		private static var logger:ILogger = LogUtil.getLog(NodePM);								
		private var sort:Sort = null;
		
		[Inject]
		public var nu:NodeUtil;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Bindable] 
		[Inject]
		public var model:SharedModel;		
		
		[Bindable] public var nodes:IList;
		[Bindable] public var selectedNode:NodeDTO;		
		public var selectedNodes:Vector.<Object>; 			// for delete/clear data
		[Bindable] public var incomingEdges:ArrayCollection;
		[Bindable] public var outgoingEdges:ArrayCollection;
		public var extraNodes:ArrayCollection;
		//[Bindable] public var allNodeLabels:ArrayCollection = new ArrayCollection();
		//[Bindable] public var allNodeUsernames:ArrayCollection = new ArrayCollection();				
		
		// search criteria
		[Bindable] public var ntd:Object = NULL;
		[Bindable] public var label:String;
		//[Bindable] public var username:String;
		[Bindable] public var includeCount:Boolean = true;
		[Bindable] public var page:int = 0;
		[Bindable] public var pageSize:int = 1000;
		[Bindable] public var rangeCount:int = 0;
		[Bindable] public var nodeTotal:int;			// total node number for given criteria		
		
		
		// validators
		public var infoValidators:Array = new Array();
		public var addressValidators:Array = new Array();
		
		public function selectNode(selectedItems:Vector.<Object>):void{
			selectedNodes = selectedItems;
			if (selectedNodes == null || selectedNodes.length == 0) return;
			selectedNode = NodeDTO(selectedNodes[0]);
			
			var e:NodeEvent = new NodeEvent(NodeEvent.LOAD_CURRENT_NODE);
			e.data.nodeId = selectedNode.nodeId.toString();
			dispatcher(e);
		}
		
		public function search():void{
			var e:NodeEvent = new NodeEvent(NodeEvent.GET_NODES_BY_CRITERIA);
			if (ntd != NULL) e.data.type = String(ntd.type);
			if (label != null && label.length > 0) e.data.label = label;
			//if (username != null && username.length > 0) e.data.username = username;
			if (includeCount) e.data.count = "1";
			else delete e.data["count"];
			
			var firstResult:Number = page*pageSize;
			e.data.firstResult = firstResult.toString();
			e.data.maxResult = pageSize.toString();
						
			dispatcher(e);
		}
		
		public function resetNode():void{
			if (selectedNode == null) {
				Alert.show("Please select a node to reset.");
				return;
			}
			
			if (!selectedNode.dirty) {
				logger.debug("SelectedNode was not changed.");
				return;
			}
			
			var e:NodeEvent = new NodeEvent(NodeEvent.LOAD_CURRENT_NODE);
			e.data.nodeId = selectedNode.nodeId.toString();
			dispatcher(e);
		}
		
		public function updateNode():void{
			if (selectedNode == null) {
				Alert.show("Please specify a node to save.");
				return;
			}
			
			if (!selectedNode.dirty) {
				logger.debug("SelectedNode was not changed.");
				return;
			}
			
			if (!nu.isUsernameValid(selectedNode.username)) return;
			
			// validate other fields 
			if (!isValid()) return;		

			// save to server
			var event:NodeEvent = new NodeEvent(NodeEvent.UPDATE_NODE);
			event.data = selectedNode;
			dispatcher(event);
		}
		
		// Run all the validators.
		private function isValid():Boolean{
			var results:Array =  Validator.validateAll(infoValidators);
			var message:String;
			if(results.length > 0) {
				message = "There are invalid data entries in Basic tab!";
				Alert.show(message);
				return false;
			}	
			results = Validator.validateAll(addressValidators);
			if(results.length > 0) {
				message = "There are invalid data entries in Address tab!";
				Alert.show(message);
				return false;
			}
			return true;	
		}	
		
		public function checkUsernameAvailability(username:String):void{
			var e:NodeEvent = new NodeEvent(NodeEvent.CHECK_USERNAME_AVAILABILITY);
			e.data = username;
			dispatcher(e);
		}
		
		public function deleteNode():void{
			var nodeIds:ArrayCollection = getSelectedNodeIds();				
			if (nodeIds.contains(model.loginNode.nodeId)) {
				Alert.show("you cannot delete yourself.");
				return;
			}
			
			// TODO: don't allow deleting "admin"??
			
			var e:NodeEvent = new NodeEvent(NodeEvent.DELETE_NODES);
			e.data = new Object();
			e.data.nodeIds = nodeIds;
			dispatcher(e);
		}
		
		public function getSelectedNodeIds():ArrayCollection{
			var nodeIds:ArrayCollection = new ArrayCollection();
			for each (var n:Object in selectedNodes){
				nodeIds.addItem(Number(n.nodeId));
			}
			return nodeIds;				
		}
	}
}