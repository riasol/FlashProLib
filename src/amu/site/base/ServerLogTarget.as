package amu.site.base
{
	import mx.core.mx_internal;

	use namespace mx_internal;
	import amu.site.events.LogSiteEvent;
	
	import mx.logging.targets.LineFormattedTarget;

	public class ServerLogTarget extends LineFormattedTarget
	{
		public function ServerLogTarget()
    {
        super();
        includeTime = true;
        includeDate = true;
        includeCategory = true;
        includeLevel = true;
    }
		override mx_internal function internalLog(message:String):void
    {
       var ev:LogSiteEvent=new LogSiteEvent(LogSiteEvent.EVENT_LOG_MESSAGE)
       ev.message=message
       ev.dispatch()
    }
	}
}