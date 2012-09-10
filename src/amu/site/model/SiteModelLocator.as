package amu.site.model {
	import amu.site.events.NavigationEvent;
	import amu.site.vo.*;

	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.model.ModelLocator;

	import flash.external.ExternalInterface;

	import flashprolib.util.AddressingUtils;
	/**
	 * Zawiera model - strukture, metody dostępu i modyfikacji
	 */
	[Bindable]
	public class SiteModelLocator implements com.adobe.cairngorm.model.ModelLocator {

		protected static var instance:amu.site.model.SiteModelLocator;
		function SiteModelLocator() {
			CairngormEventDispatcher.getInstance().addEventListener(NavigationEvent.EVENT_NAVIGATE, evNavigate)
		}
		public static function getInstance():amu.site.model.SiteModelLocator {
			if(instance == null) {
				instance=new amu.site.model.SiteModelLocator();
			}

			return instance;
		}
		public var sitemap:XML;
		/**
		 * @param String id Identyfikator strony
		 */
		public function getSitemapNode(id:String):XMLList {
			return sitemap..item.(@id == id)
		}
		public var page:XML
		public var lang:String="pl"
		//języki strony
		public var languages:Array
		//translations of page
		public var translations:Array
		public var id_site:String
		//czy przesyłać zdarzenia do zewnetrznego trackera
		public var useTracking:Boolean;
		//czy wywołano domyślny adres strony
		public var is_default_page:Boolean;
		public var is_local_test:Boolean;
		/**
		 * tablica z elementami sitemapu które są wymagane do otwarcia
		 */
		[ArrayElementType('amu.site.vo.PathItemVO')]
		public var targetPath:Array
		private function evNavigate(e:NavigationEvent):void {
			targetPath=[]
			var xmlNode:XML=getSitemapNode(e.id)[0]
			while(true) {
				var vo:PathItemVO=new PathItemVO()
				vo.id=String(xmlNode.@id)
				targetPath.push(vo)
				if(xmlNode.parent()[0].name() != 'item') {
					break;
				}
				xmlNode=xmlNode.parent()[0]
			}
			targetPath=targetPath.reverse()
			var ev:NavigationEvent=new NavigationEvent(NavigationEvent.EVENT_NEW_NAVIGATION_TARGET)
			ev.dispatch()
		}
		public function findRootItem(id:String):XML{
			var l:XMLList=getSitemapNode(id)
			if(!l[0]){
				return null
			}
			var xmlNode:XML=l[0]
			while(true) {
				if(xmlNode.parent()[0].name() != 'item') {
					break;
				}
				xmlNode=xmlNode.parent()[0]
			}
			return xmlNode
		}
		public function resolveNodesForPath(pathElems:Array):Array{
			var curList:XML=sitemap;
			var curIdx:uint=0
			var ret:Array=[]
			while(true) {
				var found:Boolean=false
				for each(var item:XML in curList.item ){
					var path:Array=AddressingUtils.pathToArray(item.@url)
					if(path[curIdx+1]==pathElems[curIdx]){
						found=true
						curIdx++
						ret.push(item)
						curList=item;
						break
					}
				}
				if(!found || curIdx==pathElems.length){
					break
				}
			}
			return ret;
		}
		/**
		 * @argument level: 0-..
		 */
		public function setPathItemTriggered(level:int):Boolean {
			if(level >= targetPath.length) {
				return false
			}
			if(PathItemVO(targetPath[level]).triggered) {
				return false
			}
			PathItemVO(targetPath[level]).triggered=true
			return true
		}
		public function readConfig():void {
			var config:Object=ExternalInterface.call('cms2.siteSwf.getConfig')
			id_site=config.id_site
			lang=config.lang
			languages=config.languages
			useTracking=config.useTracking
			is_default_page=config.is_default_page
			is_local_test=config.is_local_test
		}
		public function getStandardLocaleName():String{
		 return lang=='pl'?'pl_PL':'en_US'
		}

		/**
		 * @param paramsSource usually Application.application
		 */
		public function getRequestIds(paramsSource:Object):Array {
			var ids:Array=[]
			if(paramsSource.parameters.hasOwnProperty('locationHash') && paramsSource.parameters.locationHash!=''){

			}else{
				for(var i:uint=0; i < 10; i++) {
				var id:String='FT_ID_' + i
				if(paramsSource.parameters.hasOwnProperty(id)) {
					ids.push(paramsSource.parameters[id])
				} else {
					break;
				}
			}
			}

			return ids
		}
	}
}