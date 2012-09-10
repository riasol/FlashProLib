package amu.site.commands{
	import amu.site.business.SiteDelegate;
	import amu.site.events.NavigationEvent;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	

	public class LoadSubmenuCommand extends AbstractCommand{
		override public  function execute(e:CairngormEvent):void
			{	
				new SiteDelegate(this).getPage(NavigationEvent(e).pageRequest)
			}
		override public function result( e:Object ) : void
			{		
				var ev:NavigationEvent=new NavigationEvent(NavigationEvent.EVENT_SUBMENU_AVAILABLE)
				ev.pageRequest=e.result as PageRequestVO;
				ev.dispatch()
			} 
	}
}