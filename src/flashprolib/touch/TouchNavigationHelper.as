package flashprolib.touch
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.getTimer;

	[Event(name="SCROLL_RIGHT",type="flash.events.Event")]
	[Event(name="SCROLL_LEFT",type="flash.events.Event")]
	[Event(name="SCROLL_UP",type="flash.events.Event")]
	[Event(name="SCROLL_DOWN",type="flash.events.Event")]
	public class TouchNavigationHelper extends EventDispatcher
	{
		
		public function TouchNavigationHelper(target:DisplayObject)
		{
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT
				target.stage.addEventListener(TouchEvent.TOUCH_BEGIN,onTouchBegin)
				target.stage.addEventListener(TouchEvent.TOUCH_END,onTouchEnd)
				target.addEventListener(Event.REMOVED_FROM_STAGE,function(e:Event):void{
					target.stage.removeEventListener(TouchEvent.TOUCH_BEGIN,onTouchBegin)
					target.stage.removeEventListener(TouchEvent.TOUCH_END,onTouchEnd)
				})
		}
		private var beginPoint:Point;
		private var beginTime:Number;
		protected function onTouchBegin(e:TouchEvent):void
		{
			beginPoint=new Point(e.localX,e.localY)
				beginTime=getTimer();
		}
		protected function onTouchEnd(e:TouchEvent):void
		{
			var minScroll:uint=100;
			var endPoint:Point=new Point(e.localX,e.localY)
				var rect:Rectangle=new Rectangle(0,0,Math.abs(beginPoint.x-endPoint.x),Math.abs(beginPoint.y-endPoint.y))
				if(rect.width<minScroll && rect.height<minScroll){
					return;
				}
				if(Math.abs(rect.width-rect.height)<20){
					return;
				}
				if((getTimer()-beginTime)>3000){
					return
				}
				if(rect.width>rect.height){//on x
					if(endPoint.x>beginPoint.x){
						dispatchEvent(new Event("SCROLL_RIGHT"))
					}else{
						dispatchEvent(new Event("SCROLL_LEFT"))
					}
				}else{//on y
					if(endPoint.y>beginPoint.y){
						dispatchEvent(new Event("SCROLL_DOWN"))
					}else{
						dispatchEvent(new Event("SCROLL_UP"))
					}
				}
		}
		
	}
}