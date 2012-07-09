package edu.northwestern.ciknow.visa.presentation.savedvis
{
	import edu.northwestern.ciknow.common.util.LogUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.logging.ILogger;

	public class SavedVisualizationPM
	{
		private static const logger:ILogger = LogUtil.getLog(SavedVisualizationPM);
		
		[Bindable]
		public var createdViss:IList = new ArrayCollection();
		[Bindable]
		public var visibleViss:IList = new ArrayCollection();
		
		public function SavedVisualizationPM()
		{
		}
		
	}
}