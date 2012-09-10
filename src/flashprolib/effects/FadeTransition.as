package flashprolib.effects {
	import caurina.transitions.Tweener;

	import flash.display.DisplayObjectContainer;
	public class FadeTransition extends FPTransition {
		public var alphaStart:Number=0;
		public var alphaFinish:Number=1;
		private var _target:DisplayObjectContainer

		public function FadeTransition() {
			super();
		}
		override public function set target(v:Object):void {
			cleanup()
			_target=null;
			_target=v as DisplayObjectContainer;
		}
		private function animate():void {
			_target.alpha=alphaStart
			Tweener.addTween(_target,{
				alpha:alphaFinish
				,time:duration
				,transition:'easeInCirc'
				,onComplete:function():void {
					dispatchEvent(new FPEffectEvent(FPEffectEvent.EFFECT_END))
			}
			, onCompleteScope:this}
			)

		}
		private function cleanup():void {
		}
		override public function get target():Object {
			return _target;
		}
		override public function play():void {
			animate()
		}
		override public function stop():void {
			Tweener.removeTweens(_target)
		}

	}
}