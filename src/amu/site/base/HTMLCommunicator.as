package amu.site.base{
	
	import amu.site.events.NavigationEvent;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.external.ExternalInterface;
	/**
	 * Komunikacja ze stroną, ustawienie tytułu
	 * private var c:HTMLCommunicator;
	 * ...
	 * c=new HTMLCommunicator();
	 */ 
	public class HTMLCommunicator {
		function HTMLCommunicator(){
			createHelperHTML()
			CairngormEventDispatcher.getInstance().addEventListener(NavigationEvent.EVENT_NAVIGATE,evNavigationEvent)
		}
		private function createHelperHTML():void{
			if(ExternalInterface.available) {
				ExternalInterface.call('document.insertScript=function(){window._hc_setTitle=function(t){' + 
						'document.title=t;' + 
						'};}')
			}
		}
		private  function evNavigationEvent(e:NavigationEvent):void {
			if(ExternalInterface.available) {
				ExternalInterface.call('_hc_setTitle',e.label)
			}
	}
	}
}