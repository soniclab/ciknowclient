package edu.northwestern.ciknow.visa.presentation.savedvis
{
	import edu.northwestern.ciknow.common.domain.VisualizationDTO;
	
	import spark.formatters.DateTimeFormatter;
	import spark.skins.spark.DefaultGridItemRenderer;
	
	/**
	 * For text only ItemRenderer, extending from DefaultGridItemRenderer is a performance winner.
	 **/
	public class SavedVisualizationGridItemRenderer_TimeStamp extends DefaultGridItemRenderer
	{
		private var formater:DateTimeFormatter = new DateTimeFormatter();
		
		public function SavedVisualizationGridItemRenderer_TimeStamp()
		{
			super();
			formater.dateTimePattern = "MM/dd/yyyy, hh:mm:ss";
		}
				
		override public function prepare(willBeRecycled:Boolean):void{
			if (data == null) return;
			
			var vis:VisualizationDTO = VisualizationDTO(data);
			if (vis.valid){
				setStyle("color", "green");
				setStyle("fontStyle", "normal");
			} else {
				setStyle("color", "red");
				setStyle("fontStyle", "italic");
			}

			this.label = formater.format(vis.timestamp);
		}
	}
}