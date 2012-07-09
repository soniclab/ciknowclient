package edu.northwestern.ciknow.common.events
{	
	import flash.events.Event;

	public class RoleEvent extends Event
	{

		public static const GET_PLAIN_NODES_BY_ROLE_ID:String = "GET_PLAIN_NODES_BY_ROLE_ID";
		public static const GOT_PLAIN_NODES_BY_ROLE_ID:String = "GOT_PLAIN_NODES_BY_ROLE_ID";
		
		public static const CREATE_ROLE:String='createRole';
		public static const CREATE_ROLE_DONE:String='createRoleDone';
		
		public static const UPDATE_ROLE:String='updateRole';
		public static const UPDATE_ROLE_DONE:String='updateRoleDone';
		
		public static const DELETE_ROLE:String='deleteRole';
		public static const DELETE_ROLE_DONE:String='deleteRoleDone';		

		public static const ADD_NODE_TO_ROLE:String = "addNodeToRole";
		public static const ADDED_NODE_TO_ROLE:String = "addedNodeToRole";
		
		public static const REMOVE_NODE_FROM_ROLE:String = "removeNodeFromRole";
		public static const REMOVED_NODE_FROM_ROLE:String = "removedNodeFromRole";
		
		public var data:Object = new Object();
		
		public function RoleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new RoleEvent(type, bubbles, cancelable);
		}		
	}

}