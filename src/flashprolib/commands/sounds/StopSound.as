package flashprolib.commands.sounds {
	import flashprolib.commands.Command;
	import flashprolib.sounds.SoundManager;

	public class StopSound extends Command {
		
		public var key:String;
		
		public function StopSound(key:String) {
			this.key = key;
		}
		
		override protected function execute():void {
			SoundManager.stop(key);
			complete();
		}
	}
}