package amu.site.display{
	
	import cms2.site.vo.ImageVO;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.effects.Fade;
	import mx.effects.Tween;
	import mx.effects.TweenEffect;
	
	public class MiniatureLoader extends Sprite{
		public var imageVO:ImageVO;
		public var imageIndex:uint;
		private var loader:Loader
		function MiniatureLoader(){
			super();
			loader=new Loader()
			addChild(loader)
		}
		public function load(rq:URLRequest):void{
			loader.load(rq)
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,evComplete)
		}
		private function evComplete(e:Event):void{
			var fade:Fade=new Fade(loader)
			fade.play()
		}
	}
}