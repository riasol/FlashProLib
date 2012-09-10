/**
 *
   var ev:ContentDisplayEvent=new ContentDisplayEvent(ContentDisplayEvent.EVENT_PAGE_SHOW)
   ev.pageRequest=new PageRequestVO()
   //ev.pageRequest.url=SiteModelLocator.getInstance().getSitemapNode(pr.id_page)[0].@url
   //ev.pageRequest.url=SiteModelLocator.getInstance().getSitemapNode(pr.id_page)[0].@url+"_get/klasyfikacja/"+id
   ev.dispatch()
 */
package amu.site.base {
	import amu.site.events.ContentDisplayEvent;
	import amu.site.events.ContentTrackingEvent;
	import amu.site.model.SiteModelLocator;

	import flash.external.ExternalInterface;
	public class Tracker {
		/**
		 * Zdarzenie: zmiana strony
		 *
		 */
		public static function trackContentView(e:ContentDisplayEvent):void {
			if(SiteModelLocator.getInstance().useTracking && ExternalInterface.available) {
				var path:String="";
				if(e.pageRequest.url != '') {
					path=e.pageRequest.url
				} else {
					path=String(SiteModelLocator.getInstance().getSitemapNode(e.pageRequest.id_page)[0].@url)
				}
				if(path.indexOf("_get/") == -1) {
					if(path.lastIndexOf("/") != (path.length - 1)) {
						path+="/"
					}
					path+="_get"
				}
				path+="/client/flash"
				ExternalInterface.call("tracker.instance.trackContentView", path)
			}
			if(ExternalInterface.available) {
				//ExternalInterface.call("externalInterfaceProxy", e.pageRequest)
			}
		}
		/**
		 * Istotne zdarzenie
		 */
		public static function trackEvent(e:ContentTrackingEvent):void {
			if(SiteModelLocator.getInstance().useTracking && ExternalInterface.available) {
				ExternalInterface.call("tracker.instance.trackEvent", e.category, e.action, e.optionalLabel, e.optionalValue)
			}
		}
	}
}