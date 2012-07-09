package edu.northwestern.ciknow.common.controller
{
	import edu.northwestern.ciknow.common.domain.NodeDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.NodeEvent;
	import edu.northwestern.ciknow.common.util.GeneralUtil;
	import edu.northwestern.ciknow.common.util.LogUtil;
	import edu.northwestern.ciknow.common.util.NodeUtil;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class GetAllPlainNodesCommand
	{
		private static var logger:ILogger = LogUtil.getLog(GetAllPlainNodesCommand);
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject(id="nodeRO")]
		public var service:RemoteObject;
		
		[Inject]
		public var sm:SharedModel;
		
		[Inject]
		public var nu:NodeUtil;
		
		[Inject]
		public var gu:GeneralUtil;
		
		public function GetAllPlainNodesCommand()
		{
		}
		
		public function execute(event:NodeEvent):AsyncToken{
			logger.info("Get all plain nodes ...");
			return service.getPlainNodes();
		}
		
		public function result(event:ResultEvent, trigger:NodeEvent):void{	
			logger.info("Got plain nodes.");
			var nodes:ArrayCollection = ArrayCollection(event.result);			
			nu.initPlainNodes(nodes);
			
			var e:NodeEvent = new NodeEvent(NodeEvent.GOT_PLAIN_NODES);
			e.data = nodes;
			dispatcher(e);
		}
		
		public function error(event:FaultEvent, trigger:NodeEvent):void{
			gu.handleFault(event.fault);
		}
	}
}