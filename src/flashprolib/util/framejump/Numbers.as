package flashprolib.util.framejump{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Numbers extends Sprite {

		function Numbers() {
			addEventListener(Event.ADDED_TO_STAGE, ev);
		}
		private function ev(e:Event):void {
			MovieClip(parent).stop();
			var f:Number=MovieClip(parent).totalFrames;
			var yTr:Number=0;
			for (var i:uint=0; i<f; i++) {
				var n:Numer=new Numer();
				addChild(n);
				n.tf.text=String(i+1);
				n.addEventListener(MouseEvent.CLICK,evMClick);
				n.y=yTr;
				yTr+=44;
			}
		}
		private var lastN:Numer;
		private function evMClick(e:MouseEvent):void {
			if(lastN!=null){
				lastN.signed=false
				}
				lastN=null
				lastN=Numer(e.currentTarget)
				lastN.signed=true
			var f:Number=MovieClip(parent).totalFrames;
			var nr:Number=Number(Numer(e.currentTarget).tf.text)
			MovieClip(parent).gotoAndStop(nr);
		}
	}
}