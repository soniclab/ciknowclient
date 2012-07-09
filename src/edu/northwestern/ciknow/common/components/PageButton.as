package edu.northwestern.ciknow.common.components
{
	public class PageButton
	{
		public function PageButton(label:String, buttonWidth:Number, selected:Boolean = false)
		{
			this.label = label;
			this.width = buttonWidth;
			this.selected = selected;
		}
		
		[Bindable] public var label:String;
		[Bindable] public var width:Number;
		[Bindable] public var selected:Boolean;
	}
}