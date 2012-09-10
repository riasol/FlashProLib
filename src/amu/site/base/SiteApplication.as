package amu.site.base {
	import amu.site.business.Services;
	import amu.site.control.Controller;
	import amu.site.events.AssetEvent;
	import amu.site.events.SitemapEvent;
	import amu.site.exceptions.CodeQualityException;
	import amu.site.view.preloaders.graphicssign.GraphicsSign;
	import amu.site.vo.NaviItemVO;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.events.Event;
	import flash.net.registerClassAlias;
	
	import mx.core.Application;
	import mx.events.FlexEvent;

	public class SiteApplication extends Application implements ISiteApplication {
		public var services:Services;
		public var controller:Controller;
		public function SiteApplication() {
			super();
			HostPage.getInstance().initTracker()
			addEventListener(FlexEvent.CREATION_COMPLETE,evCreationComplete)
			addEventListener(Event.RESIZE,evStageResize)
		}
protected function evCreationComplete(e:FlexEvent):void{
				services=new Services()
			controller=new Controller()
			evStageResize()
			//ResourceBundleManager.getInstance();
			registerClassAlias("amu.site.vo.NaviItemVO", NaviItemVO);
			registerClassAlias("cms2.site.vo.PageRequestVO", PageRequestVO);
			CairngormEventDispatcher.getInstance().addEventListener(SitemapEvent.EVENT_SITEMAP_LOADED, evSitemapLoaded)
			CairngormEventDispatcher.getInstance().addEventListener(AssetEvent.EVENT_ASSET_LOAD_START, evAssetLoadStart)
			CairngormEventDispatcher.getInstance().addEventListener(AssetEvent.EVENT_ASSET_LOADED, evAssetLoaded)
			new SitemapEvent(SitemapEvent.EVENT_LOAD_SITEMAP).dispatch()
}
		public function evStageResize(e:Event=null):void {
			//if(stage is Stage) {
			//}
		}

		public function evSitemapLoaded(e:SitemapEvent):void {
			evStageResize()
			var ev:AssetEvent=new AssetEvent(AssetEvent.EVENT_LOAD_ASSET)
			ev.assetName="SiteAssets"
			ev.dispatch()
		}

		public function evAssetLoadStart(e:AssetEvent):void {
			var ldr:GraphicsSign=new GraphicsSign()
			ldr.initialize()
			//ui.addChild(ldr)
			GraphicsSign.instance.loaderInfo=e.loader.contentLoaderInfo
		}

		public function evAssetLoaded(e:AssetEvent):void {
			if(e.assetName == "SiteAssets") {
				startUI()
			}
		}
		protected function startUI():void {
			throw new CodeQualityException(CodeQualityException.NOT_OVERRIDEN)
		}
	}
}