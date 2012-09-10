package flashprolib.util{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;


	public class ScrollableDisplayObject extends Sprite{
		private var dispRef:DisplayObject;
		private var rect:Rectangle;
		private var maxHeight:Number;
		/**
		 * 0-1
		 */
		private var stepFraction:Number=0;
		/**
		 * -1/1
		 */
		private var direction:int;
		public var fractionDelta:Number=0.03
		public var round:Boolean
		public var step:Number=4;
		private var btns:Array=[]
		private var setupFlag:Boolean
		/**
		 * Ważne dla textfield: używać tej metody po wstawieniu tekstu
		 */
		public function setup(obj:DisplayObject,rect:Rectangle,size:Point=null):void{
			if(setupFlag){
				trace("ScrollableDisplayObject: setup used again")
				return
			}
			setupFlag=true
			dispRef=obj;
			if(dispRef is TextField){
				TextField(dispRef).height=TextField(dispRef).textHeight+10
			}
			if(size is Point){
				maxHeight=size.y
			}else{
				maxHeight=dispRef.height
			}

			dispRef.scrollRect=rect
			this.rect=rect
		}
		public function addButton(b:*):void{
			btns.push(b)
		}
		/**
		 * scrolluje w osi Y, zwraca false jeśli osiągnięto granice
		 */
		public function scrollY(dy:Number):Boolean{
			var newY:Number=rect.y-dy
			var limit:Boolean=false
			if(newY<0){
				newY=0;
				limit=true
			}else if(newY>(maxHeight-rect.height)){
				newY=maxHeight-rect.height
				limit=true
			}
			rect.y=newY
			dispRef.scrollRect=rect
			return limit
		}
		/**
		 * dy -1 or 1
		 * @return Boolean Does come limit
		 */
		public function scrollYSmooth(dir:int):Boolean{
			var prevY:Number=newY
			var dirChanged:Boolean=dir!=direction
			direction=dir
			if(dirChanged){
				stepFraction=0
			}
			stepFraction=Math.min(stepFraction+fractionDelta,1)
			var newY:Number=rect.y-(step*direction*stepFraction)
			if(round){
				newY=Math.round(newY)
			}
			var limit:Boolean=false
			if(newY<0){
				newY=0;
				limit=true
			}else if(newY>(maxHeight-rect.height)){
				newY=maxHeight-rect.height
				limit=true
			}
			rect.y=newY
			dispRef.scrollRect=rect
			if(newY!=prevY){
				for each(var d:ScrollableDynamicButtonDecorator in btns){
					d.checkEnabled()
				}
			}
			return limit
		}
		public function calculateNew(dir:int):Boolean{
			var dirChanged:Boolean=dir!=direction
			stepFraction=Math.min(stepFraction+fractionDelta,1)
			var tNewY:Number=rect.y-(step*dir*stepFraction)
			if(round){
				tNewY=Math.round(tNewY)
			}
			var limit:Boolean=false
			if(tNewY<0){
				limit=true
			}else if(tNewY>(maxHeight-rect.height)){
				limit=true
			}
			return limit
		}
		public function resetSmooth():void{
			stepFraction=0
		}
	}
}