package flashprolib.util {
	import flash.utils.ByteArray;


	public class CoreUtils {
		public static function copyObjectProperties(source:*, dest:*, fieldNames:String):void {
			var fields:Array=fieldNames.split(' ')
			for(var i:uint=0; i < fields.length; i++) {
				dest[fields[i]]=source[fields[i]]
			}
		}
		public static function clone(source:Object):* {
			var myBA:ByteArray=new ByteArray();
			myBA.writeObject(source);
			myBA.position=0;
			return(myBA.readObject());
		}
		public static function generateUnique():String {
			var date:Date=new Date()
			var ret:String=""
			ret+=date.time + "" + date.milliseconds + "" + Math.random() * 10000000
			return ret;
		}
	}
}