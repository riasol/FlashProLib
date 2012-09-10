package amu.site.view{
	
	import amu.site.assets.ScrollBar;
	
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	/**
	 * 
	 w obsłudze tekstu
	 	if(scroll==null){
			scroll=new ScrollBarController(new ScrollBar())
			addChild(scroll)
			scroll.x=...
			savedTfY=tf.y
		}
			asset.contentTF.y=savedTfY
			scroll.setTarget(tf,new Rectangle(...))
	 */ 
	public class ScrollBarController extends Sprite{
		public var stepArrow:Number=0.01
		public var asset:ScrollBar;
		protected var scrolling:Boolean
		protected var arrowRef:InteractiveObject
		protected var knobRef:InteractiveObject
		protected var proportion:Number;
		protected var prevProportion:Number;
		protected var scrollHeight:Number;
		protected var targetObjectY0:Number;
		protected var targetObject:InteractiveObject
		public var useMask:Boolean=true;
		private var savedY:Number;
		function ScrollBarController(asset:ScrollBar){
			super()
			scrolling=false
			this.asset=asset
		}
		private function evArrowPress(e:MouseEvent):void{
			arrowRef=e.currentTarget as InteractiveObject
			scrolling=true
		}
		private function evArrowRelease(e:MouseEvent):void{
			arrowRef=null
			scrolling=false
		}
		private function evStageUp(e:MouseEvent):void{
			stopScrolling()
		}
		protected function stopScrolling():void{
			if(scrolling){
				scrolling=false
				knobRef=null
				asset.knob.stopDrag()
			}
		}
		protected function evKnobPress(e:MouseEvent):void{
			knobRef=e.currentTarget as InteractiveObject
			scrolling=true
			asset.knob.startDrag(false,new Rectangle(asset.knob.x,asset.knobLimits.y,0,asset.knobLimits.height))
		}
		public function setTarget(v:*,scrollRect:Rectangle):void{
			if(isNaN(savedY)){
				savedY=v.y
			}else{
				v.y=savedY
			}
			proportion=prevProportion=0
			asset.knob.y=asset.knobLimits.y
			targetObject=v
			targetObjectY0=targetObject.y
			targetObject.scrollRect=scrollRect
			if(targetObject is TextField){
				scrollHeight=TextField(targetObject).textHeight-scrollRect.height
			}else if(targetObject is Sprite){
				scrollHeight=Sprite(targetObject).height-scrollRect.height
			}
			scrolling=scrollHeight>0
			if(scrolling){
				start()
			}else if(numChildren==1){//TODO Nieładne
				removeChild(asset)
			}
			
		}
		private function start():void{
			//TODO
			if(stage==null){
				return
			}
			addChild(asset); 
			asset.minusArrow.addEventListener(MouseEvent.MOUSE_DOWN,evArrowPress,false,0,true);
			asset.minusArrow.addEventListener(MouseEvent.MOUSE_UP,evArrowRelease,false,0,true)
			asset.plusArrow.addEventListener(MouseEvent.MOUSE_DOWN,evArrowPress,false,0,true)
			asset.plusArrow.addEventListener(MouseEvent.MOUSE_UP,evArrowRelease,false,0,true)
			asset.knob.buttonMode=true
			asset.knob.mouseChildren=false
			asset.knob.addEventListener(MouseEvent.MOUSE_DOWN,evKnobPress,false,0,true)
			stage.addEventListener(MouseEvent.MOUSE_UP,evStageUp,false,0,true)
			if(useMask){
				asset.knob.mask=asset.knobMask
			}else{
				asset.knobMask.visible=false
			}
			addEventListener(Event.ENTER_FRAME,evEnterFrame,false,0,true)
		}
		protected function evEnterFrame(e:Event):void{
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
				proportion=(asset.knob.y-asset.knobLimits.y)/(asset.knobLimits.height-asset.knobLimits.y)
			}
			if(proportion!=prevProportion){
				prevProportion=proportion
				var sc:Rectangle=targetObject.scrollRect
				sc.y= proportion*scrollHeight
				targetObject.scrollRect=sc
				if(arrowRef!=null){
					asset.knob.y=asset.knobLimits.y+asset.knobLimits.height*proportion
				}
			}
		}
		public function set useArrows(b:Boolean):void{
			asset.minusArrow.visible=asset.plusArrow.visible=b
		}
	}
}