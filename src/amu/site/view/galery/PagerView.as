package amu.site.view.galery
{
	import amu.site.events.GaleryEvent;
	
	import cms2.site.vo.ImageVO;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import flashprolib.util.DisplayUtils;
	
	public class PagerView extends Sprite
	{
		public var pager:Pager;
		private var galery:Galery;
		private var config:PagerViewConfig;
		private var miniaturesContainer:Sprite;
		private var leftArrow:DisplayObject;
		private var rightArrow:DisplayObject;
		private var triggeredFirst:Boolean
		public function PagerView(g:Galery){
			super()
			triggeredFirst=false
			galery=g 
			miniaturesContainer=new Sprite()
			addChild(miniaturesContainer)
			CairngormEventDispatcher.getInstance().addEventListener(GaleryEvent.EVENT_GALERY_MINIATURE_SELECT,evMiniatureSelect)
		}
		public function configure(c:PagerViewConfig):void{
			config=c
		}
		public function showSet(dir:int):void{
			if(leftArrow==null){
				leftArrow=new config.leftArrowClass() as DisplayObject
				addChild(leftArrow)
				leftArrow.addEventListener(MouseEvent.CLICK,evArrowClick);
				leftArrow.x=config.leftArrowPosition[0];
				leftArrow.y=config.leftArrowPosition[1];
				if(config.leftArrowPosition.length==3){
					leftArrow.rotation=	config.leftArrowPosition[2]
				}
				rightArrow=new config.rightArrowClass() as DisplayObject
				rightArrow.x=config.rightArrowPosition[0];
				rightArrow.y=config.rightArrowPosition[1];
				if(config.rightArrowPosition.length==3){
					rightArrow.rotation=config.rightArrowPosition[2]
				}
				addChild(rightArrow)
				rightArrow.addEventListener(MouseEvent.CLICK,evArrowClick)
				miniaturesContainer.x=config.miniaturesPosition[0]
				miniaturesContainer.y=config.miniaturesPosition[1]
				setChildIndex(miniaturesContainer,numChildren-1)
			}
			DisplayUtils.removeAllChildren(miniaturesContainer)
			var miniaturesOnSet:uint=pager.config.colsNr*pager.config.rowsNr;
			pager.pageIndex+=dir
			var start:uint=pager.pageIndex*miniaturesOnSet
			var end:uint=Math.min((pager.pageIndex+1)*miniaturesOnSet,galery.images.length)
			var miniPositions:Array=[0,0]
			var firstMiniature:Miniature
			for(var i:uint=start;i<end;i++){
				var m:Miniature= new config.miniatureClass() as Miniature
				miniaturesContainer.addChild(m)
				if(firstMiniature==null){
					firstMiniature=m
				}
				m.x=miniPositions[0]
				m.y=miniPositions[1]
				if((i+1)%pager.config.colsNr==0){
						miniPositions[1]+=config.ySpace;
						miniPositions[0]=0;
					}else{
						miniPositions[0]+=config.xSpace;
					}
				m.load(galery.images[i] as ImageVO,i)
			}
			leftArrow.visible=start>0
			rightArrow.visible=end<galery.images.length
			if(!triggeredFirst){
				triggeredFirst=true
				firstMiniature.trigger()
			}
		} 
		private function evMiniatureSelect(e:GaleryEvent):void{
			
		}
		private function evArrowClick(e:MouseEvent):void{
			showSet(e.currentTarget==leftArrow?-1:1)
		}
		
	}
}