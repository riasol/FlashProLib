package flashprolib.assetloader {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import flashprolib.util.IoUtils;

	public class SimpleAssetLoader extends EventDispatcher {
		public static const EVENT_LOADED:String='EVENT_LOADED/flashprolib/assetloader/SimpleAssetLoader'
			public function load(pathS:String):void{
				var path:URLRequest= new URLRequest(pathS);
				var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,evAssetsLoadComplete);
				IoUtils.ioErrorsGuard(loader.contentLoaderInfo)
				loader.load(path,context);
			}
			private function evAssetsLoadComplete(e:Event):void{
				 dispatchEvent(new Event(EVENT_LOADED))
			}
	}
}