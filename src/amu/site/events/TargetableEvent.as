package amu.site.events
{
	
	import com.adobe.cairngorm.control.CairngormEvent;

	public class TargetableEvent extends CairngormEvent
	{
		public var eventTarget:Object
		function TargetableEvent(type:String, bubbles : Boolean = false, cancelable : Boolean = false,tg:Object=null){
			eventTarget=tg
			super(type,bubbles,cancelable);
		}
	}
}