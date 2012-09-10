package amu.site.view.galery
{
	import amu.site.events.GaleryEvent;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	public class ScrollArrowView extends Sprite
	{
		private var asset:DisplayObject
		public function ScrollArrowView(asset:DisplayObject){
			this.asset=asset
			addChild(asset)
			addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void{
				var ev:GaleryEvent=new GaleryEvent(GaleryEvent.EVENT_GALERY_SCROLL_ARROW_CLICK)
				ev.direction=name=="left"?-1:1
				ev.dispatch()
			})
			CairngormEventDispatcher.getInstance().addEventListener(GaleryEvent.EVENT_GALERY_NEW_IMAGE_SELECT,
			function(e:GaleryEvent):void{
				if(name=="left"){
					visible=e.imageIndex>0
				}else if(name=="right"){
					visible=e.imageIndex<(e.imagesCount-1)
				}
			})
		}
		
	}
}