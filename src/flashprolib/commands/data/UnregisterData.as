package flashprolib.commands.data {
	import flashprolib.commands.Command;
	import data.DataManager;
	
	//this command unregisters data from the data manager
	public class UnregisterData extends Command {
		
		public var key:String;
		
		public function UnregisterData(key:String) {
			this.key = key;
		}
		
		override protected function execute():void {
			DataManager.unregisterData(key);
			complete();
		}
	}
}