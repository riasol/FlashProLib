package flashprolib.apis.google {
	public class RszEnum {
		public static const TYPE_SMALL:String='small';
		public static const TYPE_LARGE:String='large';
		private var type:String
		public function RszEnum(s:String) {
			type=s
		}
		 public function toString():String {
			return type
		}
	}
}