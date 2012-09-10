package flashprolib.fix {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Poprawka bedu występującego w iexpore 8: stage.stageWidth ( stage.stageHeight ) ma wartość 0
	 * przy korzystaniu z swf zapisanego w cache
	 */
	public class IEStage extends Sprite {
		private var handle:Function
		private var tmr:Timer;
		/**
		 * @param container DisplayObjectContainer do którego dołączony zostanie fix
		 * @param method Function metoda która zostanie wywołana po zaistnieniu wartości  stageWidth>0
		 * Using:
		 * var fix:IEStage=new IEStage(this,startDisplayObejcts)
		 */
		function IEStage(container:DisplayObjectContainer, method:Function) {
			handle=method
			container.addChild(this)
			tmr=new Timer(20)
			tmr.addEventListener(TimerEvent.TIMER, testStageSize)
			tmr.start()
			testStageSize()//wywołanie, które zadziała dla browser != ie8, żeby nie było opóźnień
		}
		private function testStageSize(e:TimerEvent=null):void {
			if(stage.stageWidth > 0 && stage.stageHeight > 0) {
				tmr.stop()
				tmr.removeEventListener(TimerEvent.TIMER, testStageSize)
				handle.apply(parent)
				parent.removeChild(this)
			}
		}
	}
}