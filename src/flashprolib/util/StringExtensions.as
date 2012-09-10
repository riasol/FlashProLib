package flashprolib.util {

	public class StringExtensions {
		public static function splitString(inString:String, separator:String):Array {
			var ret:Array=[]
			if(inString.indexOf(separator) > -1) {
				ret=inString.split(separator)
			} else {
				ret=[inString]
			}
			return ret;
		}
	}
}