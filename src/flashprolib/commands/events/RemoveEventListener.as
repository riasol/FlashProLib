package flashprolib.commands.events {
	import flashprolib.commands.Command;
	import flash.events.IEventDispatcher;
	
	//this command encapsulates the removeEventListener() method
	public class RemoveEventListener extends Command {
		
		public var dispatcher:IEventDispatcher;
		public var type:String;
		public var listener:Function;
		
		public function RemoveEventListener(dispatcher:IEventDispatcher, type:String, listener:Function) {
			this.dispatcher = dispatcher;
			this.type = type;
			this.listener = listener;
		}
		
		override protected function execute():void {
			dispatcher.addEventListener(type, listener);
			complete();
		}
	}
}