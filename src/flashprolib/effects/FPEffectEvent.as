package flashprolib.effects
{
	import flash.events.Event;

	public class FPEffectEvent extends Event
	{
		public static const EFFECT_END:String="EFFECT_END";
		public function FPEffectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}