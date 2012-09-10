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
	
	

	public class QueryCommand extends AbstractCommand{
		override public  function execute(e:CairngormEvent):void
			{	
				new SiteDelegate(this).query(ContentEvent(e).pageRequest)
			}
		override public function result( e:Object ) : void{
				var pr:PageRequestVO= PageRequestVO(e.result);
				var ev:ContentEvent=new ContentEvent(ContentEvent.EVENT_QUERY_RESULT)
				ev.pageRequest=pr
				ev.dispatch()
		}
	}
}