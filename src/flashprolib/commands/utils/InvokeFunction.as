package flashprolib.commands.utils {
	import flashprolib.commands.Command;
	
	//this command invokes a function
	public class InvokeFunction extends Command{
		
		public var func:Function;
		public var args:Array;
		
		public function InvokeFunction(func:Function, args:Array = null) {
			this.func = func;
			this.args = args;
		}
		
		override protected function execute():void {
			func.apply(null, args);
			complete();
		}
	}
}