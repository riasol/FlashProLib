package amu.site.view.galery
{
	import amu.site.events.GaleryEvent;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class ImageView extends Sprite
	{
		protected var loader:Loader
		public function ImageView(){
			loader=new Loader()
			addChild(loader)
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,evComplete)
			CairngormEventDispatcher.getInstance().addEventListener(GaleryEvent.EVENT_GALERY_NEW_IMAGE_SELECT,evMiniatureSelect)
		}
		protected function evComplete(e:Event):void{
			
		}
		protected function evMiniatureSelect(e:GaleryEvent):void{
			var rq:URLRequest=new URLRequest(e.image.image)
			loader.load(rq)
		}
	}
}