package flashprolib.commands.data {
	import flashprolib.commands.Command;
	import flashprolib.data.DataManager;
	
	//this command registers data to the data manager
	public class RegisterData extends Command {
		
		public var key:String;
		public var data:*;
		
		public function RegisterData(key:String, data:*) {
			this.key = key;
			this.data = data;
		}
		
		override protected function execute():void {
			DataManager.registerData(key, data);
			complete();
		}
	}
}