package flashprolib.collector {
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class CollectorKeyListener {
		public var collector:Collector
		public function CollectorKeyListener(keyInput:InteractiveObject) {
			keyInput.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown)
		}
		/**
		 * 
		 */ 
		private function evKeyDown(e:KeyboardEvent):void {
			if(e.ctrlKey && e.shiftKey) {
				if(e.keyCode >= 48 && e.keyCode <= 57) {
					var bufIndex:uint=e.keyCode - 48
					collector.print(bufIndex)
				}
			}
		}
		
	}
}