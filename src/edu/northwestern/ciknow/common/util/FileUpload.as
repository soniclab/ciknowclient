package edu.northwestern.ciknow.common.util
{	
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.events.GeneralEvent;
	import edu.northwestern.ciknow.common.popup.TextDisplayPopup;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.core.DeferredInstanceFromClass;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.spicefactory.parsley.core.context.Context;
	
	public class FileUpload
	{		
		private static var logger:ILogger = LogUtil.getLog(FileUpload);
		
        private var uploadURL:URLRequest;
		private var file:FileReference;
		
		public var p:TextDisplayPopup = null;		
        public var msg:String = null;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject]
		public var model:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		[Inject]
		public var context:Context;
		
		public var fileUploadTitle:String = "File Upload";
		public var fileUploadMessage:String = "Importing ...";
		public var fileUploadSuccessTitle:String = "Upload Success";
		public var fileUploadSuccessMessage:String = "File is uploaded sucessfully. " + 
			"If the file is VERY large, the server may take a few minutes to process. " + 
			"You also need to refresh browser or re-login in order to see the update.";
		public var fileUploadFailedTitle:String = "Upload Failed";
		public var fileUploadSecurityErrorMessage:String = "Security Error!";
		
		public function FileUpload()
		{
            file = new FileReference();
			
			file.addEventListener(Event.SELECT, selectHandler);
			file.addEventListener(Event.OPEN, openHandler);
			file.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			file.addEventListener(Event.COMPLETE, completeHandler);            
			file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);  		
		}
		
        public function upload(url:URLRequest):void {
        	if (url == null){
        		Alert.show("Please specify uploadURL.");
        		return;
        	}
        	uploadURL = url;
            //file.browse(getTypes());
            file.browse();
        }

        private function getTypes():Array {
            var allTypes:Array = new Array(getImageTypeFilter(), getTextTypeFilter());
            return allTypes;
        }

        private function getImageTypeFilter():FileFilter {
            return new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png");
        }

        private function getTextTypeFilter():FileFilter {
            return new FileFilter("Text Files (*.txt, *.rtf)", "*.txt;*.rtf");
        }

        private function selectHandler(event:Event):void {
            var file:FileReference = FileReference(event.target);
            logger.info("selectHandler: name=" + file.name + " URL=" + uploadURL.url);
            file.upload(uploadURL);		
        }
        
        private function openHandler(event:Event):void {
            logger.info("openHandler: " + event);
            
			p = new TextDisplayPopup();
			context.viewManager.addViewRoot(p);
			gu.showPopup(p);
			p.title = fileUploadTitle;
			p.imagesource = model.baseURL + "/images/upload.jpg";
			p.msg = fileUploadMessage;
			p.textColor = 0x000000;
			p.showCloseButton(false);
        }

        private function progressHandler(event:ProgressEvent):void {
            var file:FileReference = FileReference(event.target);
            logger.info("progressHandler name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
            //p.message.text = "Progress: " + event.bytesLoaded/event.bytesTotal*100 + "%";
        }
        
        private function completeHandler(event:Event):void {  
			logger.info(event.toString());
			
			// update the status popup windows
			p.title = fileUploadSuccessTitle;
			if (msg == null) {
				msg = fileUploadSuccessMessage;
			}
			p.msg = msg;
			p.textColor = 0x006400;
			p.showCloseButton(true);
			
			// notify file uploaded
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.FILE_UPLOADED);
			e.data.url = uploadURL;
			e.data.file = file;
			dispatcher(e);
        }
        
        private function ioErrorHandler(event:IOErrorEvent):void {	
			logger.info(event.toString());
			p.title = fileUploadFailedTitle;
			p.textColor = 0xff0000;
			p.showCloseButton(true);
				
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GET_ERROR_MSG);
			e.data = model.loginNode.nodeId.toString();
			dispatcher(e);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
			logger.info(event.toString());
			
			p.title = fileUploadFailedTitle;
			p.msg = fileUploadSecurityErrorMessage;
			p.textColor = 0xff0000;
			p.showCloseButton(true);
        }
	}
}