package amu.site.base{
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.TraceTarget;
	
	
	public class LoggingManager{
		private static var instance:LoggingManager
		public static function getInstance():LoggingManager{
			if(instance==null){
				instance=new LoggingManager()
			}
			return instance;
		}
		public function configureTraceTarget(categories:Array=null):void{
			var logTarget:TraceTarget = new TraceTarget();
			if(categories is Array){
				logTarget.filters=categories;
			}
            logTarget.level = LogEventLevel.ALL;
            logTarget.includeDate = true;
            logTarget.includeTime = true;
            logTarget.includeCategory = true;
            logTarget.includeLevel = true;
            Log.addTarget(logTarget);

		}
	}
}