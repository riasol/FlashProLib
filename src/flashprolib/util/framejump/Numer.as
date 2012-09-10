package flashprolib.util.framejump
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.filters.*;

	public class Numer extends Sprite
	{
		public var tf:TextField
		public function Numer()
		{
			super();
			mouseChildren=false
			buttonMode=true
		}
		public function set signed(b:Boolean):void{
			filters=b?[new GlowFilter()]:[]
			}
	}
}