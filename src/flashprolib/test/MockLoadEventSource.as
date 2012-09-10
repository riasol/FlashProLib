package flashprolib.test{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flashprolib.util.MathExtensions;

	public class MockLoadEventSource extends EventDispatcher {
		private var t:Timer
		private var step:Number
		public function MockLoadEventSource(sec:Number=3) {
			bt=MathExtensions.randomInRange(100, 1000,true)
			var tmrStep:Number=40
			step=bt/(sec*1000/tmrStep)
			t=new Timer(tmrStep)
			t.addEventListener(TimerEvent.TIMER, evTimer)
			t.start()
		}
		private var bl:Number=0
		private var bt:Number=0
		private function evTimer(e:TimerEvent):void {
			bl=Math.min(bl, bt)
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, bl, bt))
			if(bl>0 && bl == bt) {
				dispatchEvent(new Event(Event.COMPLETE, false, false))
				t.stop()
			}
			bl+=step
		}
	}
}