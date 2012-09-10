package amu.site.base {
	import amu.site.events.ContentDisplayEvent;
	import amu.site.events.ContentTrackingEvent;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.external.ExternalInterface;
	
	import mx.core.Application;

	public class HostPage {
		public function HostPage() {
		}
		private static var instance:HostPage
		public static function getInstance():HostPage {
			if(instance == null) {
				instance=new HostPage()
			}
			return instance
		}
		/**
		 * @deprecated
		 * @see amu.site.model.SiteModelLocator
		 * @return Array zestaw identyfikatorów sitemapu za podstawie requestu
		 */
		public function getRequestIds():Array {
			var ids:Array=[]
			for(var i:uint=0; i < 10; i++) {
				var id:String='FT_ID_' + i
				if(Application.application.parameters.hasOwnProperty(id)) {
					ids.push(Application.application.parameters[id])
				} else {
					break;
				}
			}
			return ids
		}
		public function initTracker():void {
			CairngormEventDispatcher.getInstance().addEventListener(ContentDisplayEvent.EVENT_PAGE_SHOW, Tracker.trackContentView)
			CairngormEventDispatcher.getInstance().addEventListener(ContentTrackingEvent.EVENT_ANY_EVENT, Tracker.trackEvent)
		}
		
	}
}