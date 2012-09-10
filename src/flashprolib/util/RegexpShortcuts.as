package flashprolib.util{
public class RegexpShortcuts {
   public function mailLinks(inStr:String):String{
   	var pat:RegExp=/([a-zA-Z\._-]+)@([a-zA-Z\._-]+)/
   	var ret:String=inStr.replace(pat,'<a href="mailto:$1@$2">$1@$2</a>')
   	return ret
   }
   public function wwwLinks(inStr:String):String{
   	var pat:RegExp=/(www\.[a-zA-Z\._\-,]+)/
   	var ret:String=inStr.replace(pat,'<a href="http://$1" target="_blank">$1</a>')
   	return ret
   }
}
}