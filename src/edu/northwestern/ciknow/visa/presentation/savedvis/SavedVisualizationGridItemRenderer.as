package edu.northwestern.ciknow.visa.presentation.savedvis
{
	import edu.northwestern.ciknow.common.domain.VisualizationDTO;
	
	import spark.skins.spark.DefaultGridItemRenderer;
	
	/**
	 * For text only ItemRenderer, extending from DefaultGridItemRenderer is a performance winner.
	 * Because this item render is so generic (not bind to specific column), this renderer can
	 * be applied to DataGrid rather than GridColumn.
	 * 
	 * For more regular item renderer implementation, please reference to VisColorItemRenderer.mxml,
	 * which extend GridItemRenderer and override prepare() method
	 **/
	public class SavedVisualizationGridItemRenderer extends DefaultGridItemRenderer
	{
		public function SavedVisualizationGridItemRenderer()
		{
			super();
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
		}
	}
}