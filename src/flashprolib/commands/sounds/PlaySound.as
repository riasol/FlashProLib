package flashprolib.commands.sounds {
	import flashprolib.commands.Command;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flashprolib.sounds.SoundManager;
	
	/**
	 * This command plays a sound.
	 */
	public class PlaySound extends Command {
		
		public var key:String;
		public var sound:Sound;
		public var startTime:int;
		public var loops:int;
		public var transform:SoundTransform;
		
		public function PlaySound(key:String, sound:Sound, startTime:int = 0, loops:int = 0, transform:SoundTransform = null) {
			this.key = key;
			this.sound = sound;
			this.startTime = startTime;
			this.loops = loops;
			this.transform = transform;
		}
		
		override protected function execute():void {
			
			//tell the sound manager to play the sound
			SoundManager.play(key, sound, startTime, loops, transform);
			
			//complete the command
			complete();
		}
	}
}