package flashprolib.effects {
	import caurina.transitions.Tweener;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;

	import flashprolib.util.DisplayUtils;

	public class ResizeTransition extends FPTransition {
		public var scaleStart:Number=2
		//Array of percent center offset
		public var center:Array=[0.5, 0.5]
		private var holderName:String='ResizeTransitionHolder';
		private var ut:Utils
		public function ResizeTransition() {
			super();
			ut=new Utils()
		}
		private var _target:DisplayObjectContainer
		override public function set target(v:Object) {
			cleanup()
			_target=null;
			_target=v as DisplayObjectContainer;
		}
		private var placeholder:Sprite
		private function animate():void {
			var sp1:Sprite=new Sprite()
			var sp2:Sprite=new Sprite()
			var b:Bitmap=DisplayUtils.cloneAsBitmap(_target, null, false, PixelSnapping.NEVER, true)
			sp2.addChild(b)
			sp1.addChild(sp2)
			var original:Array=[_target.width, _target.height]
			var rescaled:Array=[_target.width * scaleStart, _target.height * scaleStart]
			sp1.x=original[0] *center[0]
			sp1.y=original[1] *center[1]
			sp2.x=-original[0] / 2
			sp2.y=-original[1] / 2
			ut.removeChildren(_target)
			placeholder=new Sprite();
			placeholder.name=holderName;
			placeholder.addChild(sp1)
			_target.addChild(placeholder)
			sp1.scaleX=sp1.scaleY=scaleStart
			var p:Object={_scale:1, time:duration, transition:'easeInOutQuart'
					, onComplete:function():void {
					dispatchEvent(new FPEffectEvent(FPEffectEvent.EFFECT_END))
				}
				, onCompleteScope:this
				}
			p.x=original[0] / 2
			p.y=original[1] / 2
			Tweener.addTween(sp1, p)
		}
		override public function play():void {
			animate()
		}
		private function cleanup():void {
			if(_target && _target.getChildByName(holderName)) {
				_target.removeChild(placeholder)
				ut.attachChildren(_target)

			}
		}
	}
}