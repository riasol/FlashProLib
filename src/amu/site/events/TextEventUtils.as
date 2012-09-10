package amu.site.events
{
	import flash.events.TextEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class TextEventUtils
	{
		public static function evLinkClick(e:TextEvent):void{
			if(e.text.indexOf("href,")>-1){
				var a:Array=e.text.split(",")
				navigateToURL(new URLRequest(a[1]))
			}
		}
		public static function linkService(e:TextEvent):Array{
			var ret:Array=[]
			if(e.text.indexOf("href,")>-1){
				var a:Array=e.text.split(",")
				var href:String=a[1]
				var target:String=""
				if(a.length==3){
					target=a[2]
				}
				if(href.indexOf("http")==0){
					navigateToURL(new URLRequest(a[1]))
					return ret
				}else if(href.indexOf("mailto")==0){
					navigateToURL(new URLRequest(a[1]),"_parent")
					return ret
				}else if(target=="_blank"){
					navigateToURL(new URLRequest(a[1]))
					return ret
				}else if(href.indexOf("cms_id")==0){
					var a2:Array=href.split("/")
					return a2
				}else{
					ret=[a[1]]
					if(a.length==3){
						ret.push(a[2])
					}
				}
			}
			return ret;
		}
	}
}