package edu.northwestern.ciknow.common.util
{
    import edu.northwestern.ciknow.common.domain.SharedModel;
    import edu.northwestern.ciknow.common.events.GeneralEvent;
    import edu.northwestern.ciknow.common.popup.TextDisplayPopup;
    
    import flash.events.*;
    import flash.net.FileReference;
    import flash.net.URLRequest;
    
    import mx.controls.Alert;
    import mx.core.DeferredInstanceFromClass;
    import mx.logging.ILogger;
    import mx.logging.Log;
    
    import org.spicefactory.parsley.core.context.Context;
			    
	public class FileDownload{	
		private static var logger:ILogger =LogUtil.getLog(FileDownload);	
		  	
        private var downloadURL:URLRequest;
		private var defaultFilename:String = "downloadfile";
		private var file:FileReference;		
		
        [MessageDispatcher]
		public var dispatcher:Function;		
		
		[Inject]
		public var model:SharedModel;
		
		[Inject]
		public var gu:GeneralUtil;
		
		[Inject]
		public var context:Context;
		
		public var msg:String;
		public var p:TextDisplayPopup = null;
		
		public var fileDownloadTitle:String = "File Download";
		public var fileDownloadMessage:String = "Exporting ...";
		public var fileDownloadSuccessTitle:String = "Download Success";
		public var fileDownloadSuccessMessage:String = "File is downloaded sucessfully.";
		public var fileDownloadFailedTitle:String = "Download Failed";
		public var fileDownloadSecurityErrorMessage:String = "Security Error!";
		
        public function FileDownload() {
        	file = new FileReference();
			
        	file.addEventListener(Event.SELECT, selectHandler);
        	file.addEventListener(Event.OPEN, openHandler);
            file.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            file.addEventListener(Event.COMPLETE, completeHandler);            
            file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        }

		public function download(url:URLRequest, filename:String=null):void{
			if (url == null){
				Alert.show("Please specify URLRequest.");
				return;
			}
			downloadURL = url;
			if (filename != null) defaultFilename = filename;
			file.download(downloadURL, defaultFilename);
		}

        private function selectHandler(event:Event):void {
            var file:FileReference = FileReference(event.target);
            logger.info("selectHandler: name=" + file.name + " URL=" + downloadURL.url);
            
			p = new TextDisplayPopup();
			context.viewManager.addViewRoot(p);
			gu.showPopup(p);
			p.title = fileDownloadTitle;
			p.imagesource = model.baseURL + "/images/download.jpg";
			p.msg = fileDownloadMessage;
			p.textColor = 0x000000;
			p.showCloseButton(false);
        }

        private function openHandler(event:Event):void {
            logger.info("openHandler: " + event);              
        }

        private function progressHandler(event:ProgressEvent):void {
            var file:FileReference = FileReference(event.target);
            logger.info("progressHandler name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);   
            //p.message.text = "Received: " + event.bytesLoaded/1000 + "KB";       
        }
                        
        private function completeHandler(event:Event):void {
			// update the status popup windows
			p.title = fileDownloadSuccessTitle;
			if (msg == null) msg = fileDownloadSuccessMessage;
			p.msg = msg;
			p.textColor = 0x006400;
			p.showCloseButton(true);
			
			// notify file downloaded
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.FILE_DOWNLOADED);
			e.data.url = downloadURL;
			e.data.file = file;
			dispatcher(e);
        }
        
        private function ioErrorHandler(event:IOErrorEvent):void {
			logger.info(event.toString());
			p.title = fileDownloadFailedTitle;
			p.textColor = 0xff0000;
			p.showCloseButton(true);
			
			var e:GeneralEvent = new GeneralEvent(GeneralEvent.GET_ERROR_MSG);
			e.data = model.loginNode.nodeId.toString();
			dispatcher(e);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
			logger.info(event.toString());
			p.title = fileDownloadFailedTitle;
			p.msg = fileDownloadSecurityErrorMessage;
			p.textColor = 0xff0000;
			p.showCloseButton(true);
        }

	}
}