package amu.site.events
{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	

	public class AnimationEvent extends CairngormEvent
	{
		public static const EVENT_LOAD_ANIMATIONS:String="EVENT_LOAD_ANIMATIONS";
		public static const EVENT_ANIMATION_LOADED:String="EVENT_ANIMATION_LOADED";
		public var keys:Array
		public var loaded:Array;
		function AnimationEvent(type:String){
			super(type)
		}
	}
}