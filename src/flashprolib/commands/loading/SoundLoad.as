package flashprolib.commands.loading {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import flashprolib.commands.Command;
	
	/**
	 * This command loads a sound.
	 */
	public class SoundLoad extends Command {
		
		public var sound:Sound;
		public var url:URLRequest;
		public var emptyOnly:Boolean;
		
		public function SoundLoad(sound:Sound, url:URLRequest,emptyOnly:Boolean=true) {
			this.sound = sound;
			this.url = url;
			this.emptyOnly = emptyOnly;
		}
		
		override protected function execute():void {
			if(emptyOnly && sound.bytesTotal >0 && sound.bytesLoaded/sound.bytesTotal==1){
				complete();
			}else{
				sound.addEventListener(Event.COMPLETE, onComplete);
			sound.load(url);
			}
		}
		
		private function onComplete(e:Event):void {
			
			//remove the complete listener
			sound.removeEventListener(Event.COMPLETE, onComplete);
			
			//complete the command
			complete();
		}
	}
}