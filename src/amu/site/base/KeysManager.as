package amu.site.base {

	import flash.display.InteractiveObject;
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.utils.Base64Encoder;


	public class KeysManager {
		private static var instance:KeysManager
		public static function getInstance():KeysManager {
			if(instance == null) {
				instance=new KeysManager()
			}
			return instance;
		}
		/**
		 * @arguments keyInput may be stage
		 */ 
		public function contributeDefault(keyInput:InteractiveObject):void {
			keyInput.addEventListener(KeyboardEvent.KEY_DOWN, evSystemKey)
		}
		private function evSystemKey(e:KeyboardEvent):void {
			if(e.ctrlKey && e.shiftKey) {
				switch(e.keyCode) {
					case 76: //l
					ExternalInterface.call('document.insertScript=function(){window.cms2.getDocumentLocation=function(){' +
				'return encodeURIComponent(String(location))' +
				'};}')
				var l:String=ExternalInterface.call('cms2.getDocumentLocation')
						var enc:Base64Encoder=new Base64Encoder()
						navigateToURL(new URLRequest('/adm/vsw/light/?return='+l),'_top')
						break;
				}
			}
		}
		public function setFocus():void {
			ExternalInterface.call('document.insertScript=function(){window.cms2.setSwfFocus=function(id){' +
				'document.getElementById(id).focus();' +
				'};}')
			ExternalInterface.call('cms2.setSwfFocus', ExternalInterface.objectID)
		}

	}
}