package flashprolib.fix {
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.events.DynamicEvent;
	import mx.managers.SystemManager;
	
	public class CatchCallLaterExceptions {
		public function catchExceptions(component:UIComponent):void{
			UIComponentGlobals.catchCallLaterExceptions=true
			component.systemManager.addEventListener('callLaterError', evCallLaterError)
		}
		public function stopCatching(component:UIComponent):void{
			UIComponentGlobals.catchCallLaterExceptions=false
			component.systemManager.removeEventListener('callLaterError', evCallLaterError)
		}		
		private function evCallLaterError(e:DynamicEvent):void {
			trace(e.error.message)
		}
		
	}
}