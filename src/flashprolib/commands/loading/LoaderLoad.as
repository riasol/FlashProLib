package flashprolib.commands.loading {
	import flashprolib.commands.Command;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	public class LoaderLoad extends Command {
		
		public var loader:Loader;
		public var url:URLRequest;
		public var context:LoaderContext;
		
		public var onProgress:Command;
		public var onComplete:Command;
		
		public function LoaderLoad(loader:Loader, url:URLRequest, context:LoaderContext = null, onProgress:Command = null, onComplete:Command = null) {
			this.loader = loader;
			this.url = url;
			this.context = context;
			this.onProgress = onProgress;
			this.onComplete = onComplete;
		}
		
		override protected function execute():void {
			
			//add listeners
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressListener);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadingComplete);
			
			//start loading
			loader.load(url, context);
		}
		
		private function loadingComplete(e:Event):void {
			
			//remove listeners
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressListener);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeListener);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadingComplete);
			
			complete();
		}
		
		private function progressListener(e:ProgressEvent):void {
			
			//execute the onProgress command
			if (onProgress) onProgress.start();
		}
		
		private function completeListener(e:Event):void {
			
			//execute the onComplete command
			if (onComplete) onComplete.start();
		}
	}
}