package flashprolib.util {


	public class AddressingUtils {
		public static function pathToArray(source:String):Array {
			var pathS:String=source.replace(/^\//, "")
			pathS=pathS.replace(/\/$/, "")
			var path:Array=pathS.split('/')
			return path;
		}
	}
}