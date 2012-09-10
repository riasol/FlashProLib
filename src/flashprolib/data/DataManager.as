package flashprolib.data {
	import flash.utils.Dictionary;
	
	public class DataManager {
		
		//a dictionary that maintains the string-data relations
		private static var _data:Dictionary = new Dictionary();
		
		//returns the data object associated with a key string
		public static function getData(key:String):* {
			return _data[key];
		}
		
		//registers a data object with a key string
		public static function registerData(key:String, data:*):void {
			_data[key] = data;
		}
		
		//unregisters a key string
		public static function unregisterData(key:String):void {
			delete _data[key];
		}
		
		//unregisters all key strings
		public static function clearData():void {
			for (var key:String in _data) {
				delete _data[key];
			}
		}
	}
}