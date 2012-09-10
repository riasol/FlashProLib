package amu.site.tool {
	import flash.external.ExternalInterface;

	public class JsBridge {
		/**
		 *Insert js code into html DOM
		 * @param js javascript code
		 *
		 */
		public function injectJs(js:String):void {
			if(ExternalInterface.available) {
				ExternalInterface.call('document.insertScript=function(){' + js + '}')
			}
		}
		public function jsonDecode(json:String):Object {
			var result:Object=ExternalInterface.call('document.insertScript=function(a){'
				+ 'return eval("("+a+")");'
				+ '}', json)
			return result;
		}
	}
}