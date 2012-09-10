package flashprolib.util {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;

	public class IoUtils {
		public static function ioErrorsGuard(obj:IEventDispatcher):void {
			obj.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
					trace('IOErrorEvent.IO_ERROR ' + e.text)
				})
		}
	}
}