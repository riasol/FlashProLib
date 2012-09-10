package amu.site.business{
	
	
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AbstractService;
	import mx.rpc.IResponder;


	public class LogDelegate{
		private var responder:IResponder;
		private var service :AbstractService
		function LogDelegate(rp:IResponder){
			responder=rp 
			service=ServiceLocator.getInstance().getRemoteObject( "LogService" )
		}
		public function logMessage(msg:String) : void{	
				var call : Object=service.publicLogSwf(msg);
				call.addResponder( responder );
			}
		}
}