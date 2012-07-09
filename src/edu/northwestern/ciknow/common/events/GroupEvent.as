package edu.northwestern.ciknow.common.events
{
	import flash.events.Event;

	public class GroupEvent extends Event
	{
		public static const GET_PLAIN_NODES_BY_GROUP_ID:String = "GET_PLAIN_NODES_BY_GROUP_ID";
		public static const GOT_PLAIN_NODES_BY_GROUP_ID:String = "GOT_PLAIN_NODES_BY_GROUP_ID";
		
		public static const CREATE_GROUP:String='createGroup';
		public static const CREATE_GROUP_DONE:String='createGroupDone';
		
		public static const UPDATE_GROUP:String='updateGroup';
		public static const UPDATE_GROUP_DONE:String='updateGroupDone';
		
		public static const DELETE_GROUP:String='deleteGroup';
		public static const DELETE_GROUP_DONE:String='deleteGroupDone';
		
		public static const ADD_NODE_TO_GROUP:String = "addNodeToGroup";
		public static const ADDED_NODE_TO_GROUP:String = "addedNodeToGroup";
		
		public static const REMOVE_NODE_FROM_GROUP:String = "removeNodeFromGroup";
		public static const REMOVED_NODE_FROM_GROUP:String = "removedNodeFromGroup";
		
		// SelectGroups.mxml
		public static const INIT_SELECT_GROUPS:String = "INIT_SELECT_GROUPS";
		
		public var data:Object = new Object();
		
		public function GroupEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new GroupEvent(type, bubbles, cancelable);
		}
	}

}