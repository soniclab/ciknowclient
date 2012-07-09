package edu.northwestern.ciknow.app.preloader
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.events.RSLEvent;
	import mx.preloaders.SparkDownloadProgressBar;

	public class CIKNOWPreloader extends SparkDownloadProgressBar
	{
		[Embed(source="/images/splash.jpg")]
		[Bindable]
		private var imgCls:Class;
		
		private var _barBG:Sprite;
		private var _bar:Sprite;
		private var _currentRSL:String;
		
		private var _progressText:TextField;
		private var _textFormat:TextFormat;
		
		private var _mainAppLoaded:Boolean = false;
		
		public function CIKNOWPreloader()
		{
			super();
		}		
		
		override public function get backgroundColor():uint{
			return 0x800080;
		}
		
		override public function get backgroundAlpha():Number{
			return 0.5;
		}
		
		override protected function createChildren():void{
			// Draw the background first
			//graphics.beginFill(backgroundColor, backgroundAlpha);
			//graphics.drawRect(0, 0, stageWidth, stageHeight);
			
			// sonic logo at the center
			var img:DisplayObject = new imgCls();
			addChild(img);
			img.x = (stageWidth - img.width)/2;
			img.y = (stageHeight - img.height)/2;
			
			
			// preload bar background
			_barBG = new Sprite();
			_barBG.graphics.beginFill( 0xffffff );
			_barBG.graphics.drawRect( 0, 0, img.width, 10 );
			_barBG.x = img.x;
			_barBG.y = img.y + img.height + 10;
			addChild( _barBG );
			
			// preload bar
			_bar = new Sprite();
			_bar.x = _barBG.x + 1;
			_bar.y = _barBG.y + 1;
			addChild( _bar );
			
			
			// text display
			_progressText = new TextField();
			_progressText.text = "LOADING";
			_progressText.width = img.width;
			_progressText.height = 100;
			
			_textFormat = new TextFormat();
			_textFormat.font = 'Arial';
			_textFormat.size = 16;
			
			_progressText.setTextFormat( _textFormat );
			
			_progressText.x = img.x;
			_progressText.y = _barBG.y + _barBG.height + 10;
			
			addChild( _progressText );		
		}
		
		override protected function rslProgressHandler(evt:RSLEvent):void{
			if (_progressText){
				if (evt.rslIndex && evt.rslTotal) {
					//create text to track the RSLs being loaded
					var rslBaseText:String = "loading RSL " + (evt.rslIndex + 1) + " of " + evt.rslTotal + ": ";	
					var url:String = evt.url.url;
					var rsl:String = url.substring(url.lastIndexOf("/") + 1);
					_progressText.text = (rslBaseText + Math.round((evt.bytesLoaded/evt.bytesTotal)*100).toString() + "% (" + rsl + ")");
					if (_currentRSL != rsl){
						_currentRSL = rsl;
						trace(_progressText.text);
					}
					
					var progress:Number = (evt.bytesLoaded/evt.bytesTotal + evt.rslIndex)/evt.rslTotal;
					drawProgressBar(progress);				
				}
			}
		}
		
		/**
		 * This function seems to be called by both main application download and 
		 * RSL swf download. So it should be disabled once the main application is loaded.
		 */
		override protected function setDownloadProgress(completed:Number, total:Number):void{
			if (_progressText && !_mainAppLoaded){
				if (completed == total) _mainAppLoaded = true;
				drawProgressBar(completed/total);
				_progressText.text = "Loading app: " + Math.round( ( completed / total ) * 100 ) + "%";
				trace(_progressText.text);
			}
		}
		
		override protected function setInitProgress(completed:Number, total:Number):void{
			if (_progressText){
				drawProgressBar(completed/total);
				//set loading text
				if (completed > total) {
					_progressText.text = "almost done";
				} else {
					_progressText.text = "initializing " + completed + " of " + total;
				}
			}
		}
		
		/* */
		// always show download display
		override protected function showDisplayForDownloading(elapsedTime:int, event:ProgressEvent):Boolean{
			return true;
		}
		
		// always show init display
		override protected function showDisplayForInit(elapsedTime:int, count:int):Boolean{
			return true;
		}
		
		
		/**
		 *  Event listener for the <code>FlexEvent.INIT_COMPLETE</code> event.
		 *  NOTE: This event can be commented out to stop preloader from completing during testing
		 */
		override protected function initCompleteHandler(event:Event):void
		{
			dispatchEvent(new Event(Event.COMPLETE)); 
		}
		
		private function drawProgressBar(progress:Number):void{
			_bar.graphics.clear();
			_bar.graphics.beginFill( 0x800080, 0.9);
			_bar.graphics.drawRect( 0, 0, (_barBG.width - 2) * progress, 8 );
		}
	}
}