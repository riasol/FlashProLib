package flashprolib.flexx {
	import flash.events.Event;

	import flashprolib.util.SimpleSharedObject;

	import mx.containers.TabNavigator;
	import mx.events.FlexEvent;

	public class MemorableTabNavigator extends TabNavigator {
		private var memo:SimpleSharedObject
		public function MemorableTabNavigator() {
			super()
			addEventListener(FlexEvent.INITIALIZE, function(e:FlexEvent):void {
					memo=new SimpleSharedObject('memorableTabNavigator' + id)
					var si:int=memo.read('idx', 0) as int;
					selectedIndex=si;
					addEventListener(Event.CHANGE, evSelect);
				});
		}
		private function evSelect(e:Event):void {
memo.save('idx',selectedIndex)
		}

	}
}