package amu.site.base {
	import amu.site.model.SiteModelLocator;

	import flash.display.LoaderInfo;
	import flash.events.ErrorEvent;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;


	public class GlobalErrorService {
		private static var instance:GlobalErrorService;
		private var loaderInfo:LoaderInfo;
		function GlobalErrorService(loaderInfo:LoaderInfo) {
			if(instance != null) {
				throw new Error('GlobalErrorService can only once be used')
			}
			instance=this;
			this.loaderInfo=loaderInfo;
			if(loaderInfo.hasOwnProperty('uncaughtErrorEvents')) {
				loaderInfo['uncaughtErrorEvents'].addEventListener('uncaughtError', uncaughtErrorHandler);
			}
		}
		private static var lastUncauhtError:String;
		private function uncaughtErrorHandler(e:*):void {
			try {
				var msg:String=''
				var traceString:String=''
				if(e.error is Error) {
					var typedErr:Error=Error(e.error)
					msg=typedErr.message
					traceString=typedErr.getStackTrace()
				} else if(e.error is ErrorEvent) {
					var typedErrEv:ErrorEvent=ErrorEvent(e.error)
					msg=typedErrEv.text
				}
				if(traceString!=lastUncauhtError){
					traceString=lastUncauhtError
					ExternalInterface.call('globalLog', msg, null, loaderInfo.url, null, null, 'flash', traceString, Capabilities.version)
				}
				if(!SiteModelLocator.getInstance().is_local_test){
					e.preventDefault()
				}
			} catch(er:Error) {
				trace('In GlobalErrorService ' + er.message)
			}
		}

	}
}