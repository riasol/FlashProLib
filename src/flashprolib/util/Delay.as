package flashprolib.util
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class Delay extends EventDispatcher
	{
		public var delayMiliseconds:int=1000;
		private var timerPointer:uint;
		public static const EVENT_DELAY_OVER:String='EVENT_DELAY_OVER'
		public function Delay(target:IEventDispatcher=null)
		{
			super(target);
		}
		public function start():void{
			clearTimeout(timerPointer)
			timerPointer=setTimeout(evTimerOut,delayMiliseconds)
			//trace('start')
		}
		public function stop():void{
			clearTimeout(timerPointer)
			//trace('stop')
		}
		private function evTimerOut():void{
			dispatchEvent(new Event(EVENT_DELAY_OVER))
		}
		
	}
}