package amu.site.base {
	import amu.site.events.ContentDisplayEvent;
	import amu.site.events.NavigationEvent;
	import amu.site.model.SiteModelLocator;
	import amu.site.view.NavigationItemTransfer;

	import com.adobe.cairngorm.control.CairngormEventDispatcher;

	import flash.external.ExternalInterface;

	import flashprolib.util.AddressingUtils;
	import flashprolib.util.DataTransform;

	import mx.logging.Log;


	public class HistoryManager {
		private static var instance:HistoryManager
		function HistoryManager() {

		}
		public static function getInstance():HistoryManager {
			if(instance == null) {
				instance=new HistoryManager()
			}
			return instance;
		}
		public function initHistoryManagement():void {
			if(ExternalInterface.available) {
				ExternalInterface.addCallback("evHistoryItem", evHistoryItem);
				ExternalInterface.call('cms2.historyInit')
			}
			CairngormEventDispatcher.getInstance().addEventListener(ContentDisplayEvent.EVENT_PAGE_SHOW, evContentDisplayEvent)
		}
		private var lastItems:Array=['', ''];
		private function evContentDisplayEvent(e:ContentDisplayEvent):void {
			if(ExternalInterface.available) {
				var pathS:String=String(SiteModelLocator.getInstance().getSitemapNode(e.pageRequest.id_page)[0].@url)
				var path:Array=AddressingUtils.pathToArray(pathS)
				var getPart:Array=[]
				var getS:String='';
				for(var p:String in e.pageRequest.getParams) {
					getS+=(p + e.pageRequest.getParams[p])
					getPart.push({k:p, v:e.pageRequest.getParams[p]})
				}
				if(lastItems[0] == pathS && lastItems[1] == getS) {
					return
				}
				if(externalTriggerCount == 1 && lastHistoryPath == pathS && getS == '') { //jeśli to pierwsze wywołanie path+get, nie może być samo path bo get jest do modułu podrzędnego
					return
				}
				lastItems[0]=pathS
				lastItems[1]=getS;
				ExternalInterface.call("cms2.historySave", path, getPart)
			}
		}
		private var externalTriggerCount:int=0
		private var lastHistoryPath:String=''
		private var _lastHistoryParams:Object={}
		/**
		 * Getting new item from outside
		 */
		public function evHistoryItem(path:*=null, gets:*=null):void {
			externalTriggerCount++
			//trace(path[0])
			var nList:Array
			var id:String
			var dTr:DataTransform=new DataTransform()
			var pathA:Array=dTr.arrayObject2Array(path);
			lastHistoryPath='/' + pathA.join('/') + '/'
			var getsA:Array=dTr.arrayObject2Array(gets);
			if(pathA[1]) {
				pathA.shift()
				nList=SiteModelLocator.getInstance().resolveNodesForPath(pathA)
			} else { //domyślna strona
				var ar:Array=HostPage.getInstance().getRequestIds()
				id=ar.pop()
			}
			if(nList != null && nList[0]) {
				id=nList[nList.length - 1].@id
			}
			Log.getLogger("history").info("From js HistoryManager.evHistoryItem, resolved id: {0} with path {1}", id, path[1])
			if(id != null) {
				var naviEv:NavigationEvent=new NavigationEvent(NavigationEvent.EVENT_NEW_HISTORY_ITEM)
				var tr:NavigationItemTransfer=new NavigationItemTransfer()
				tr.id=id
				naviEv.eventTarget=tr
				_lastHistoryParams={}
				if(getsA.length > 0) {
					naviEv.getParams={}
					for each(var o:Object in getsA) {
						naviEv.getParams[o.k]=o.v;
						_lastHistoryParams[o.k]=o.v;
					}
				}
				naviEv.dispatch()
			}
		}
		public function resetHistoryParams():void {
			_lastHistoryParams={}
		}
		public function get lastHistoryParams():Object {
			return _lastHistoryParams
		}
		/**
		 * @return Boolean Czy istnieje informacja w adresie
		 */
		public function historyFireCurrentState(checkOnly:Boolean=false):Boolean {
			var isItem:Boolean=ExternalInterface.call('cms2.historyFireCurrentState', true)
			if(!checkOnly) { //domyślne parametry ustawione z części php
				if(isItem) {
					ExternalInterface.call('cms2.historyFireCurrentState', false)
				} else if(!isItem) {
					var ar:Array=HostPage.getInstance().getRequestIds();
					var naviEv:NavigationEvent=new NavigationEvent(NavigationEvent.EVENT_NEW_HISTORY_ITEM)
					var tr:NavigationItemTransfer=new NavigationItemTransfer()
					tr.id=ar.pop()
					naviEv.eventTarget=tr
					naviEv.dispatch()
				}
			}
			return isItem
		}
		private var titFunCreated:Boolean
		public function synchronizeTitle(t:String):void {
			if(!titFunCreated) {
				titFunCreated=true
				ExternalInterface.call('document.insertScript=function(){window.cms2.setTitle=function(t){' +
					'document.title=t;' +
					'};}')
			}
			ExternalInterface.call('cms2.setTitle', t)
		}
		private var locationFunCreated:Boolean
		public function setLocationHash(v:String):void {
			if(!locationFunCreated) {
				locationFunCreated=true
				ExternalInterface.call('document.insertScript=function(){window.cms2.setLocationHash=function(p){' +
					'location.hash=p;' +
					'};}')
			}
			ExternalInterface.call('cms2.setLocationHash', v)
		}
	}
}