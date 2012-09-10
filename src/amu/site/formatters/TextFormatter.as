package amu.site.formatters {


	public class TextFormatter {
		public static function pageXMLToHTML(inStr:String, hrefToEvents:Boolean=true, ignoreWhite:Boolean=true):String {
			if(inStr == null) {
				return '';
			}
			var savedPretty:Boolean=XML.prettyPrinting
			var savedIgnoreWhite:Boolean=XML.ignoreWhitespace
			XML.ignoreWhitespace=ignoreWhite
			XML.prettyPrinting=false
			var ret:String=""
			var xPage:XML=new XML(inStr)
			if(hrefToEvents) {
				for each(var ax:XML in xPage..a) {
					ax.@href="event:href," + ax.@href
					if(XMLList(ax.@target).length() == 1) {
						ax.@href+="," + ax.@target
					}
				}
			}
			var cmsNS:Namespace=xPage.namespace("cms")
			var b:*=xPage.cmsNS::body[0]
			for each(var x:XML in b.*) {
				ret+=x.toXMLString()
			}
			XML.prettyPrinting=savedPretty
			XML.ignoreWhitespace=savedIgnoreWhite
			return ret
		}
		/**
		 * Formatuje m^2
		 */
		public static function formatm2(inp:*, htmlFormat:Boolean=false):String {
			var inFormated:String=""
			if(inp is String) {
				inFormated=String(inp)
			} else if(typeof(inp) == "number") {
				inFormated=String(inp)
			}
			var additional:String=htmlFormat ? "m<sup>2</sup>" : "m²"
			return inFormated + additional
		}
	}
}