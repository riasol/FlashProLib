package flashprolib.sounds {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	/**
	 * This class allows you to manage sounds in terms of sound tracks.
	 */
	public class SoundManager{
		
		//a dictionary that keeps tracks of all sound tracks
		private static var _soundTracks:Dictionary = new Dictionary();
		
		//a dictionary that maps a sound channel to its corresponding key for playback completion handling
		private static var _soundKeys:Dictionary = new Dictionary();
		
		/**
		 * Plays a sound and returns a corresponding sound track object.
		 */
		public static function play(key:String, sound:Sound, startTime:int = 0, loops:int = 0, transform:SoundTransform = null):SoundTrack {
			
			//if the sound track is occupied, stop the current sound track
			if (isPlaying(key)) stop(key);
			
			//play the sound, creating a new sound channel
			var channel:SoundChannel = sound.play(startTime, loops, transform);
			
			//listen for the complete event of the sound channel
			channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
			//create a new sound track
			var soundTrack:SoundTrack = new SoundTrack(key, channel);
			
			//add the sound track to the dictionary
			_soundTracks[key] = soundTrack;
			
			//add the channel-key mapping relation
			_soundKeys[channel] = key;
			
			return soundTrack;
		}
		
		/**
		 * Returns a reference to the sound track corresponding to the provided key string.
		 */
		public static function getSoundTrack(key:String):SoundTrack {
			return _soundTracks[key];
		}
		
		/**
		 * Determins if a sound track is currently playing.
		 */
		public static function isPlaying(key:String):Boolean {
			return Boolean(_soundTracks[key]);
		}
		
		/**
		 * Stops a sound track.
		 */
		public static function stop(key:String):void {
			var soundTrack:SoundTrack = _soundTracks[key];
			
			//check if the sound track exists
			if (soundTrack) {
				
				//stop the sound track
				soundTrack.stop();
				
				//and remove it from the dictionary
				delete _soundTracks[key];
				
				//along with the channel-key relation
				delete _soundKeys[soundTrack.channel];
			}
		}
		
		/**
		 * Removes a sound track when the sound playback is complete
		 */
		private static function onSoundComplete(e:Event):void {
			
			//cast the event dispatcher to a sound channel object
			var channel:SoundChannel = SoundChannel(e.target);
			
			//remove the event listener
			channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
			//extract the corresponding key
			var key:String = _soundKeys[channel];
			
			//remove the sound track
			stop(key);
		}
	}
}