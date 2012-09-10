package flashprolib.effects {
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;

	public class FPTransition extends EventDispatcher implements IFPTransition {
		[Event(name="EFFECT_END", type="flashprolib.effects.FPEffectEvent")]
		public function FPTransition() {
			super()
		}

		public function set target(v:Object):void {
			throw new IllegalOperationError('Nie zaimplementowano set target')
		}

		public function get target():Object {
			throw new IllegalOperationError('Nie zaimplementowano get target')
			return null;
		}
		private var _duration:Number=3
		public function set duration(v:Number):void {
			_duration=v
		}
		public function get duration():Number {
			return _duration
		}

		public function play():void {
			throw new IllegalOperationError('Nie zaimplementowano play()')
		}

		public function stop():void {
			throw new IllegalOperationError('Nie zaimplementowano stop()')
		}

	}
}