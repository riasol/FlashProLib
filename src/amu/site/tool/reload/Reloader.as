package amu.site.tool.reload {
	import amu.site.tool.JsBridge;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	
	import mx.core.Application;
	import mx.modules.ModuleLoader;

	public class Reloader {
		public function Reloader(object:DisplayObject) {
			reloadSelector(object)
		}
		private function reloadSelector(object:DisplayObject):void{
			if(object  is Application){
				if(ExternalInterface.available){
					var js:JsBridge=new JsBridge()
					js.injectJs('_swfReloaderGetHTML=function(id)' + 
							'{' + 
							'return document.getElementById(id).parentNode.innerHTML;' + 
							'}')
					var html:String=ExternalInterface.call('_swfReloaderGetHTML',ExternalInterface.objectID) as String
					var reTxt:String='("[a-z0-9/_\\-\\.]+\\.swf)[^ ]*"'
					var r:RegExp=new RegExp(reTxt,'gi');
					html=html.replace(r,'$1'+getReloadStr()+'"')
					js.injectJs('_swfReloaderReload=function(id,newHtml)' + 
							'{' + 
							'return document.getElementById(id).parentNode.innerHTML=newHtml;' + 
							'}')
					ExternalInterface.call('_swfReloaderReload',ExternalInterface.objectID,html)
				}
			}else if(object  is ModuleLoader){
				var ml:ModuleLoader=object as ModuleLoader
				var mlUrl:String=ml.url
				if(mlUrl.indexOf('?')>-1){
					mlUrl=mlUrl.substring(0,mlUrl.indexOf('?'))
				}
				ml.url=(mlUrl+getReloadStr())
			}else if(object  is Loader){
				var l:Loader=object as Loader
				var lUrl:String=l.contentLoaderInfo.url
				if(mlUrl.indexOf('?')>-1){
					mlUrl=mlUrl.substring(0,mlUrl.indexOf('?'))
				}
				l.load(new URLRequest(mlUrl+getReloadStr()))
			}
		}
		private function getReloadStr():String{
			return '?reload='+Math.round(Math.random()*1000)
		}
	}
}