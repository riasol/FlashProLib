package amu.site.control{
	import amu.site.commands.*;
	import amu.site.events.AnimationEvent;
	import amu.site.events.AssetEvent;
	import amu.site.events.ContentEvent;
	import amu.site.events.LogSiteEvent;
	import amu.site.events.NavigationEvent;
	import amu.site.events.ResourceBundleEvent;
	import amu.site.events.SitemapEvent;
	
	import com.adobe.cairngorm.control.FrontController;
	
	public class Controller extends FrontController{
		public function Controller()
			{
				addCommand(SitemapEvent.EVENT_LOAD_SITEMAP, LoadSitemapCommand);
				addCommand(AssetEvent.EVENT_LOAD_ASSET,LoadAssetCommand)
				addCommand(NavigationEvent.EVENT_SUBMENU_REQUIRED,LoadSubmenuCommand)
				addCommand(AnimationEvent.EVENT_LOAD_ANIMATIONS,LoadAnimationsCommand)
				addCommand(ContentEvent.EVENT_LOAD_PAGE,LoadPageCommand)
				addCommand(ContentEvent.EVENT_LOAD_PAGES,LoadPagesCommand)
				addCommand(ContentEvent.EVENT_QUERY,QueryCommand)
				addCommand(ResourceBundleEvent.EVENT_LOAD_TRANSLATION_GROUP,LoadTranslationGroupCommand)
				addCommand(LogSiteEvent.EVENT_LOG_MESSAGE,LogMessageCommand)
			}
		
	}
}