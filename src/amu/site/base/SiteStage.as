/**
 * Wyświetlanie swf-owej zawartości we flexie
 */
package amu.site.base
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;

	public class SiteStage extends UIComponent
	{
		private var siteCanvas:Sprite;
		public function SiteStage()
		{
			super();
		}
		override protected function createChildren():void
		{
			super.createChildren();
			siteCanvas=new Sprite()
			addChild(siteCanvas)
		}
		public function addFlashChild(obj:DisplayObject):void{
			 addChild(obj)//TODO
		}
		public function removeFlashChild(obj:DisplayObject):void{
			removeChild(obj)//TODO
		}
	}
}