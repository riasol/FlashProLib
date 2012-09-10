package flashprolib.debug
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class TestConsole extends Sprite
	{
		public var keyCode:uint=84//t
		public function TestConsole()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,evAdded)
		}
		private function evAdded(e:Event):void{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, evKey)
		}
		private function evKey(e:KeyboardEvent):void {
			if(e.ctrlKey && e.shiftKey && e.keyCode==keyCode) {
				visible= !visible
			}
		}
	}
}