package amu.site.base{
	/**
	 * Light structure model
	 */
	public class Sitemap{
		public var source:XML
		 function Sitemap(xml:XML){
		 	source=xml
		}
		public function getSitemapNode(id:String):XMLList{
			return source..item.(@id==id)
		}
	}
}