package flashprolib.util {
	import flash.system.Capabilities;



	public class SystemUtils {
		public static function playerVersion():Object {
			var ret:Object={}
			var c:String=Capabilities.version
			var ar:Array=c.split(' ')
			// majorVersion,minorVersion,buildNumber,internalBuildNumber.
			ret.platform=ar[0]
			ar=ar[1].split(',')
			ret.majorVersion=ar[0]
			ret.minorVersion=ar[1]
			ret.buildNumber=ar[2]
			ret.internalBuildNumber=ar[3]
			return ret
		}
	}
}