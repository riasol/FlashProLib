package flashprolib.text {
	import flash.text.TextField;


	public class TextUtils {
		public static function htmlToText(inStr:String):String {
			var testF:TextField=new TextField()
			testF.htmlText=inStr
			return testF.text
		}
		public static function ucFirstAll(inStr:String):String {
			var d:Array=inStr.split(' ')
				for(var i:uint=0;i<d.length;i++){
					if(d[i].length>3){
						d[i]=d[i].substr(0,1).toUpperCase()+d[i].substr(1).toLowerCase()
					}
				}
			return d.join(' ')
		}
	}
}