package amu.site.base{
	import amu.site.events.ContentDisplayEvent;
	import amu.site.events.ContentTrackingEvent;
	import amu.site.events.NavigationEvent;
	import amu.site.model.SiteModelLocator;
	import amu.site.vo.PathItemVO;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.external.ExternalInterface;
	import flash.net.LocalConnection;
	
	import mx.core.Application;
	/**
	 * @deprecated
	 */ 
	public class Site{
		public var lang:String;
		public var languages:Array;
		public var useTracking:Boolean;
		private static var instance:Site
		public static function getInstance():Site{
			if(instance==null){
				instance=new Site()
			}
			return instance;
		}
		function Site(){
			CairngormEventDispatcher.getInstance().addEventListener(ContentDisplayEvent.EVENT_PAGE_SHOW,Tracker.trackContentView)
			CairngormEventDispatcher.getInstance().addEventListener(ContentTrackingEvent.EVENT_ANY_EVENT,Tracker.trackEvent)
			var ap:Object=Application.application
			useTracking=ap.parameters.hasOwnProperty('useTracking') && ap.parameters.useTracking=="true"
			ExternalInterface.addCallback("evHistoryItem", evHistoryItem);
			}
		
		private function evHistoryItem(o:Object):void{
			trace(o)
		}
		private var _id_site:String
		public function set id_site(v:String):void{
			 _id_site=v;
			// initLC() TODO
		}
		public function get id_site():String{
			return _id_site
		}
		private var lc:LocalConnection
		
		private function initLC():void{
			try{
				lc=new LocalConnection();
				lc.allowDomain("*")
				lc.connect("_siteConnection"+id_site)
				lc.client=this
			}catch(e:Error){
				trace("Local connection initialized")
			}
		}
		public function reloadAnimations():void{
			AnimationManager.getInstance().reloadAnimations()
		}
		public function get baseDir():String{
			return ""
		}
		public function setSitemapTargetIds(a:Array):void{
			SiteModelLocator.getInstance().targetPath=[]
			for each(var el:String in a){
				var vo:PathItemVO=new PathItemVO()
				vo.id=el
				SiteModelLocator.getInstance().targetPath.push(vo)
			}
			new NavigationEvent(NavigationEvent.EVENT_TARGET_PATH_CHANGED).dispatch()
		}
	}
}