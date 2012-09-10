package flashprolib.util {
	import flash.display.LoaderInfo;
	import flash.events.UncaughtErrorEvent;



	public class UncaughtErrors {
		public static function handle(loaderInfo:LoaderInfo):void {
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, function(e:UncaughtErrorEvent):void{
				e.preventDefault();
			trace(e.text)
			});
		}
	}
}