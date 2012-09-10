package amu.site.commands{
	import amu.site.assets.IRuntimeAssets;
	import amu.site.base.ContentManager;
	import amu.site.base.Site;
	import amu.site.business.SiteDelegate;
	import amu.site.events.AssetEvent;
	import amu.site.events.ContentEvent;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	

	public class LoadPageCommand extends AbstractCommand{
		private var savedId:String;
		override public  function execute(e:CairngormEvent):void
			{	
				savedId=ContentEvent(e).requestId
				new SiteDelegate(this).getPage(ContentEvent(e).pageRequest)
			}
		override public function result( e:Object ) : void{
				var pr:PageRequestVO= PageRequestVO(e.result);
				ContentManager.getInstance().push(pr)
				var ev:ContentEvent=new ContentEvent(ContentEvent.EVENT_PAGE_LOADED)
				ev.pageRequest=pr
				ev.requestId=savedId
				ev.dispatch()	
		}
	}
}