package amu.site.view.galery
{
	import amu.site.events.GaleryEvent;
	
	import cms2.site.vo.ImageVO;
	
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	public class Miniature extends Sprite
	{
		protected var loader:Loader
		protected var image:ImageVO;
		protected var imageIndex:int;
		public function Miniature(){
			loader=new Loader()
			addChild(loader)
			buttonMode=true
			mouseChildren=false
			addEventListener(MouseEvent.CLICK,evClick)
		}
		public function load(image:ImageVO,index:int):void{
			this.image=image
			imageIndex=index
			var rq:URLRequest=new URLRequest(image.miniature_path)
			loader.load(rq)
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,evComplete)
		}
		protected function evComplete(e:Event):void{
		}
		public function trigger():void{
			evClick()
		}
		protected function evClick(e:MouseEvent=null):void{
			var ev:GaleryEvent=new GaleryEvent(GaleryEvent.EVENT_GALERY_MINIATURE_SELECT)
			ev.imageIndex=imageIndex
			ev.image=image
			ev.dispatch()
		}
	}
}