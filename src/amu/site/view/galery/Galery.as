package amu.site.view.galery
{
	import amu.site.events.GaleryEvent;
	
	import cms2.site.vo.ImageVO;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	  
	 */	
	public class Galery extends Sprite
	{
		 public var pager:Pager;
		 public var pagerView:PagerView;
		 public var pagerViewClass:Class;
		 public var imageView:ImageView;
		 public var imageViewClass:Class;
		 public var images:Array;
		 private var imageIndex:int;
		 public function Galery(){
		 	pager=new Pager()
		 	imageViewClass=ImageView
		 	CairngormEventDispatcher.getInstance().addEventListener(GaleryEvent.EVENT_GALERY_MINIATURE_SELECT,evMiniatureSelect)
		 	CairngormEventDispatcher.getInstance().addEventListener(GaleryEvent.EVENT_GALERY_SCROLL_ARROW_CLICK,evScrollArrowClick)
		 	addEventListener(Event.REMOVED_FROM_STAGE,evRemoved)
		 }
		 private function evRemoved(e:Event):void{
		 	CairngormEventDispatcher.getInstance().removeEventListener(GaleryEvent.EVENT_GALERY_MINIATURE_SELECT,evMiniatureSelect)
		 	CairngormEventDispatcher.getInstance().removeEventListener(GaleryEvent.EVENT_GALERY_SCROLL_ARROW_CLICK,evScrollArrowClick)

		 }
		 public function configurePager(c:PagerConfig):void{
		 	pager.config=c
		 }
		 public function createDefaultViews():void{
		 	if(pagerViewClass!=null){
		 		pagerView=new pagerViewClass(this) as PagerView
		 	}else{
		 		pagerView=new PagerView(this)
		 	}
		  addChild(pagerView)
		  pagerView.pager=pager
		  imageView=new imageViewClass() as ImageView
		  addChild(imageView)
		 }
		 public function start(a:Array):void{
		 	//trace(a)
		 	images=null
		  images=a
		  pagerView.pager.pageIndex=-1
		  pagerView.showSet(1)
		 }
		 private function evMiniatureSelect(e:GaleryEvent):void{
		 	imageIndex=e.imageIndex
		 	dispatchImageSelect()
		 }
		 private function evScrollArrowClick(e:GaleryEvent):void{
		 	imageIndex+=e.direction
		 	dispatchImageSelect()
		 }
		 private function dispatchImageSelect():void{
		 	var ev:GaleryEvent=new GaleryEvent(GaleryEvent.EVENT_GALERY_NEW_IMAGE_SELECT)
		 	ev.image=images[imageIndex] as ImageVO
		 	ev.imageIndex=imageIndex
		 	ev.imagesCount=images.length
		 	ev.dispatch()
		 }
	}
}