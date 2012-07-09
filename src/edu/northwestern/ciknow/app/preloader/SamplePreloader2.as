package edu.northwestern.ciknow.app.preloader
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getTimer;
	
	import mx.events.RSLEvent;
	import mx.preloaders.SparkDownloadProgressBar;
	
	public class SamplePreloader2 extends SparkDownloadProgressBar
	{
		
		private var _displayStartCount:uint = 0; 
		private var _initProgressCount:uint = 0;
		private var _downloadComplete:Boolean = false;
		private var _showingDisplay:Boolean = false;
		private var _startTime:int;
		private var preloaderDisplay:PreloaderDisplay;
		private var rslBaseText:String = "loading: ";
		private var _rsl:String = null;
		
		public function SamplePreloader2()
		{
			super();
		}
		
		/**
		 *  Event listener for the <code>FlexEvent.INIT_COMPLETE</code> event.
		 *  NOTE: This event can be commented out to stop preloader from completing during testing
		 */
		override protected function initCompleteHandler(event:Event):void
		{
			dispatchEvent(new Event(Event.COMPLETE)); 
		}
		
		/**
		 *  Creates the subcomponents of the display.
		 */
		override protected function createChildren():void
		{    
			if (!preloaderDisplay) {
				preloaderDisplay = new PreloaderDisplay();
				
				var startX:Number = Math.round((stageWidth - preloaderDisplay.width) / 2);
				var startY:Number = Math.round((stageHeight - preloaderDisplay.height) / 2);
				
				preloaderDisplay.x = startX;
				preloaderDisplay.y = startY;
				addChild(preloaderDisplay);
			}
		}
		
		/**
		 * Event listener for the <code>RSLEvent.RSL_PROGRESS</code> event. 
		 **/
		override protected function rslProgressHandler(evt:RSLEvent):void {
			if (evt.rslIndex && evt.rslTotal) {
				//create text to track the RSLs being loaded
				rslBaseText = "loading RSL " + (evt.rslIndex + 1) + " of " + evt.rslTotal + ": ";
				
				var progressRsl:Number = Math.round((evt.bytesLoaded/evt.bytesTotal)*100);				
				preloaderDisplay.setDownloadRSLProgress(Math.round( evt.rslIndex*100/evt.rslTotal + progressRsl/evt.rslTotal));				
				setPreloaderLoadingText(rslBaseText + Math.round((evt.bytesLoaded/evt.bytesTotal)*100).toString() + "%");
			}
			if (_rsl != evt.url.url){
				_rsl = evt.url.url;
				trace(_rsl);
			}
		}
		
		/** 
		 *  indicate download progress.
		 */
		override protected function setDownloadProgress(completed:Number, total:Number):void {
			if (preloaderDisplay) {
				//set the main progress bar inside PreloaderDisplay
				preloaderDisplay.setMainProgress(completed/total);
				//set percetage text to display, if loading RSL the rslBaseText will indicate the number
				setPreloaderLoadingText(rslBaseText + Math.round((completed/total)*100).toString() + "%");
			}
		}
		
		/** 
		 *  Updates the inner portion of the download progress bar to
		 *  indicate initialization progress.
		 */
		override protected function setInitProgress(completed:Number, total:Number):void {
			if (preloaderDisplay) {
				//set the initialization progress bar inside PreloaderDisplay
				preloaderDisplay.setInitAppProgress(completed/total);
				//set loading text
				if (completed > total) {
					setPreloaderLoadingText("almost done");
				} else {
					setPreloaderLoadingText("initializing " + completed + " of " + total);
				}
			}
		} 
		
		private function setPreloaderLoadingText(value:String):void {
			//set the text display in the flash preloader
			preloaderDisplay.loading_txt.text = value;
		}
		
		override protected function showDisplayForDownloading(elapsedTime:int,
													 event:ProgressEvent):Boolean
		{
			return true;
		}

		override protected function showDisplayForInit(elapsedTime:int, count:int):Boolean
		{
			return true;
		}
	}
}