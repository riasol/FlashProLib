package amu.site.view{
	import amu.site.assets.ScrollBar;
	
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ScrollCircleController extends ScrollBarController{
		public var r:Number=100;
		public var centre:Array=[0,0];
		function ScrollCircleController(asset:ScrollBar){
			super(asset)
		}
		override protected function evKnobPress(e:MouseEvent):void{
			knobRef=e.currentTarget as InteractiveObject
			scrolling=true
		}
		override protected function evEnterFrame(e:Event):void{
			if(arrowRef!=null){
				if(arrowRef==asset.minusArrow){
					proportion-=stepArrow
				}else if(arrowRef==asset.plusArrow){
					proportion+=stepArrow
				}
				if(proportion<0){
					proportion=0
				}
				if(proportion>1){
					proportion=1
				}
			}else if(knobRef!=null){
				if(asset.mouseY<asset.knobLimits.y){
					asset.knob.y=Math.max(asset.knobLimits.y,asset.mouseY)
				}else{
					asset.knob.y=Math.min(asset.knobLimits.height+asset.knobLimits.y,asset.mouseY)
				}
				proportion=(asset.knob.y-asset.knobLimits.y)/(asset.knobLimits.height-asset.knobLimits.y)
				
			}
			if(proportion!=prevProportion){
				if(proportion>1.1 || proportion<-0.1){
					//stopScrolling()
				}
				proportion=Math.min(1,proportion);
				proportion=Math.max(0,proportion);
				prevProportion=proportion
				var sc:Rectangle=targetObject.scrollRect
				sc.y= proportion*scrollHeight
				targetObject.scrollRect=sc
				if(arrowRef!=null){
					asset.knob.y=asset.knobLimits.y+asset.knobLimits.height*proportion
				}
				asset.knob.x=Math.sqrt(Math.pow(r,2)-Math.pow((-asset.knob.y-centre[1]),2))+centre[0]
				
			}
		}
	}
}