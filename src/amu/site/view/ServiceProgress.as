package amu.site.view{
	import mx.core.Application;
	import mx.managers.CursorManager;
	
	
	public class ServiceProgress{
		private static var instance:ServiceProgress
		private var callCnt:Number=0;
		public var disabledLocking:Boolean=false
		function ServiceProgress(){
			
		}
		public static function getInstance():ServiceProgress{
			if(instance==null){
				instance=new ServiceProgress()
			}
			return instance
		}
		public function callStart(e:*=null):void{
				callCnt++
				if(callCnt==1){
					controllAppMouse(false)
				}
			}
		public function callFinish(e:*=null):void{
				callCnt--
				if(callCnt==0){
					controllAppMouse(true)
				}
			}
		public var controllTarget:*=null;
		private function controllAppMouse(enable:Boolean):void{
			if(controllTarget==null){
				controllTarget=Application.application
			}
				if(enable){
					controllTarget.mouseEnabled=true
					controllTarget.mouseChildren=true
				}else if(!disabledLocking){
					controllTarget.mouseEnabled=false
					controllTarget.mouseChildren=false
				}
			}
	}
}