package flashprolib.apis.google {
	import flash.events.Event;
	
	import flashprolib.apis.google.model.ResultCursor;
	
	public class GoogleApiEvent extends Event{
		public static const EVENT_RESULT_COMPLETE:String='EVENT_RESULT_COMPLETE';
		public static const EVENT_RESULT_FAULT:String='EVENT_RESULT_FAULT';
		public var data:Object;
		public var queryResult:Array;
		public var cursor:ResultCursor;
		function GoogleApiEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type,bubbles,cancelable)
		}
	}
}