package amu.site.view{
	import amu.site.base.ContentManager;
	import amu.site.events.NavigationEvent;
	import amu.site.model.SiteModelLocator;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flashprolib.util.DisplayUtils;
	
	import mx.core.UIComponent;
	
	
	
	
	public class PageDisplayContainer extends UIComponent{
	 function PageDisplayContainer(){
	 	CairngormEventDispatcher.getInstance().addEventListener(NavigationEvent.EVENT_ITEM_SELECT, evNavigationEvent)
	 }
	 	protected var currentDisplay:AbstractPageDisplay
		protected var currentDisplayString:String
		protected var currentNavigationId:String
		public function evNavigationEvent(e:NavigationEvent):void {
			currentNavigationId=e.eventTarget.id
			var newDisplayString:String=""
				switch(currentNavigationId) {
					case "":
						break;
					default:
						newDisplayString="TextDisplay"
						break;
				}
				if(newDisplayString != currentDisplayString) {
					cleanupDisplay()
					switch(newDisplayString) {
						case "TextDisplay":
							currentDisplay=new TextPageDisplay();
							break;
					}
					addChild(currentDisplay)
					currentDisplayString=newDisplayString
				}
				if(newDisplayString != "") {
					var pr:PageRequestVO=new PageRequestVO()
					pr.id_page=currentNavigationId
					pr.lang=SiteModelLocator.getInstance().lang
					currentDisplay.pageRequest=ContentManager.getInstance().getPage(pr)
				}
		}
		/**
		 * Override if transition
		 */ 
		protected function cleanupDisplay():void {
				if(DisplayUtils.isAttached(currentDisplay)) {
					removeChild(currentDisplay)
					currentDisplayString=""
				}
		}

	}
}