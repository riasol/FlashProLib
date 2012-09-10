package flashprolib.sounds {
	import flash.media.SoundChannel;
	
	/**
	 * A sound track represents a key-channel pair.
	 */
	public class SoundTrack{
		
		//read-only key value
		private var _key:String;
		public function get key():String { return _key; }
		
		//read-only sound channel reference
		private var _channel:SoundChannel;
		public function get channel():SoundChannel { return _channel; }
		
		public function SoundTrack(key:String, channel:SoundChannel) {
			_key = key;
			_channel = channel;
		}
		
		/**
		 * Stops the underlying sound channel.
		 */
		public function stop():void {
			_channel.stop();
		}
	}
}