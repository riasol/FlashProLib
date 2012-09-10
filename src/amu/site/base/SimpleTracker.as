package amu.site.base{
	
	import flash.external.ExternalInterface;
	public class SimpleTracker {
		/**
		 * SimpleTracker.trackEvent('Images','ClickImage','/modules...(path)')
		 */ 
		public static function trackEvent(category:String,action:String,optionalLabel:String='',optionalValue:String=''):void {
			if(ExternalInterface.available) {
				ExternalInterface.call("tracker.instance.trackEvent",category,action,optionalLabel,optionalValue)
			}
	}
	}
}