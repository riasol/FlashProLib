package flashprolib.apis.google {
	public class GoogleApisCommon {
		public function GoogleApisCommon() {
		}
		private static var instance:GoogleApisCommon;
		public static function getInstance():GoogleApisCommon {
			if(instance == null) {
				instance=new GoogleApisCommon()
			}
			return instance;
		}
		public var key:String
		public var v:String='1.0'
		public var userip:String;
		/**
		 * ilość zwracanych rekordów
		 */ 
		public var rsz:RszEnum;
		/**
		 * language
		 */ 
		public var hl:String;
	}
}