package amu.site.utils {
	public class PathUtils {
		public static function contructImagePath(base:String, fileExt:String, size:String):String {
			var ret:String=base;
			if(size.indexOf('x') >= -1) {
				ret+='-conf';
				ret+=size
			}
			ret+='_m';
			ret+='.';
			ret+=fileExt;
			return ret;
		}
	}
}