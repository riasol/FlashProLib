package amu.site.commands{
	import amu.site.business.LogDelegate;
	import amu.site.business.SiteDelegate;
	import amu.site.events.LogSiteEvent;
	import amu.site.events.NavigationEvent;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	

	public class LogMessageCommand extends AbstractCommand{
		override public  function execute(e:CairngormEvent):void
			{	
				new LogDelegate(this).logMessage(LogSiteEvent(e).message)
			}
		override public function result( e:Object ) : void
			{		
			} 
	}
}