package flashprolib.text{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;


	public class ScrollableText extends Sprite{
		private var tfRef:TextField;
		private var rect:Rectangle;
		private var bounds:Rectangle;
		public var step:Number=4;
		/**
		 * 0-1
		 */
		private var stepFraction:Number;
		private var direction:int;
		public var fractionDelta:Number=0.03
		public var round:Boolean
		/**
		 * Ważne żeby używać po wstawieniu tekstu
		 */
		public function setup(tf:TextField,rect:Rectangle):void{
			tfRef=tf;
			tfRef.scrollRect=rect
			this.rect=rect
			bounds=rect
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
			}else if(newY>(tfRef.textHeight-rect.height)){
				newY=tfRef.textHeight-rect.height
				limit=true
			}
			rect.y=newY
			tfRef.scrollRect=rect
			return limit
		}
		/**
		 * dy -1 or 1
		 */
		public function scrollYSmooth(dir:int):Boolean{
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
			}else if(newY>(tfRef.textHeight-rect.height)){
				newY=tfRef.textHeight-rect.height
				limit=true
			}
			rect.y=newY
			tfRef.scrollRect=rect
			return limit
		}
		public function resetSmooth():void{
			stepFraction=0
		}
	}
}