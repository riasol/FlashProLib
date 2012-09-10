package amu.site.commands{
	import amu.site.business.SiteDelegate;
	import amu.site.events.SitemapEvent;
	import amu.site.model.SiteModelLocator;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	

	public class LoadSitemapCommand extends AbstractCommand{
		override public  function execute(e:CairngormEvent):void
			{	
				new SiteDelegate(this).loadSitemap()
			}
		override public function result( e:Object ) : void
			{		
				SiteModelLocator.getInstance().sitemap=new XML(e.result)
				new SitemapEvent(SitemapEvent.EVENT_SITEMAP_LOADED).dispatch()
			} 
	}
}