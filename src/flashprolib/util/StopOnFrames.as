package flashprolib.util{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class StopOnFrames {
		/**
		 * Target to stop
		 */
		public var _target:MovieClip;
		/**
			form [[1,10],...] - stop in frame 1 on 10 frames
		 */
		public var frames:Array;
		public function set target(v:MovieClip):void {
			_target=v;
			_target.addEventListener(Event.ENTER_FRAME, evFrame)
		}
		private var stoppedOnFrame:int;
		private var stopFramesRequired:int;
		private var stopFramesCount:int;
		private function evFrame(e:Event):void {
			if(stoppedOnFrame > 0) {
				stopFramesCount++
				if(stopFramesCount == stopFramesRequired) {
					stoppedOnFrame=-1
					_target.play();
				}
				return
			}
			for each(var ar:Array in frames) {
				if(ar[0] == _target.currentFrame) {
					stoppedOnFrame=ar[0]
					stopFramesCount=0
					stopFramesRequired=ar[1]
					_target.stop()
				}
			}
		}
	}
}