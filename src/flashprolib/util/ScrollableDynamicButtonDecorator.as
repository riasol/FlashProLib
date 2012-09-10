package flashprolib.util {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;


	public class ScrollableDynamicButtonDecorator {
		private const TIMER_LOW:Number=30
		private const TIMER_HIGH:Number=15
		private var timerLow:Number=TIMER_LOW
		private var timerHigh:Number=TIMER_HIGH
		protected var timer:Timer
		private var btn:Sprite
		protected var timerTick:Number=500
		private var direction:int;
		public static const DIRECTION_UP:int=-1
		public static const DIRECTION_DOWN:int=1
		private var scrollableObject:ScrollableDisplayObject
		function ScrollableDynamicButtonDecorator(btn:Sprite, direction:int, scrollableObject:ScrollableDisplayObject) {
			this.btn=btn;
			this.direction=direction;
			this.scrollableObject=scrollableObject;
			btn.addEventListener(MouseEvent.MOUSE_DOWN, evBtnDown, false, 0, true);
			btn.addEventListener(MouseEvent.MOUSE_UP, evBtnUp, false, 0, true);
			btn.addEventListener(MouseEvent.ROLL_OVER, evBtnOver, false, 0, true);
			btn.addEventListener(MouseEvent.ROLL_OUT, evBtnOut, false, 0, true);
			btn.addEventListener(MouseEvent.CLICK, evTimerEvent, false, 0, true);
			timer=new Timer(timerTick);
			timer.addEventListener(TimerEvent.TIMER, evTimerEvent, false, 0, true);
			
		}
		public function checkEnabled():void{
			var cResult:Boolean=scrollableObject.calculateNew(direction)
			if(btn is UIComponent){
				UIComponent(btn).enabled=!cResult
			}else{
				btn.alpha=!cResult?1:0.5
			}
		}
		private function evBtnDown(e:MouseEvent):void {
			timer.delay=timerHigh
		};
		private function evBtnUp(e:MouseEvent):void {
			timer.delay=timerLow
		};
		private function evBtnOver(e:MouseEvent):void {
			timer.delay=timerLow
			timer.start()
		};
		private function evBtnOut(e:MouseEvent):void {
			timer.stop()
		};
		protected function evTimerEvent(e:*):void {
			var cResult:Boolean=scrollableObject.scrollYSmooth(direction)
			if(btn is UIComponent){
				UIComponent(btn).enabled=!cResult
			}else{
				btn.alpha=!cResult?1:0.5
			}
		}
	}
}