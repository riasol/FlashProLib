package flashprolib.debug {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	public class DebugUtils  {
		/**
		 * Using:
		 *
		 * flashprolib.debug.DebugUtils.drawRect()
		 */
		public static function drawRect(display:Sprite,rect:Rectangle):void{
			with(display.graphics){
				beginFill(0xff0000,0.5);
				drawRect(rect.x,rect.y,rect.width,rect.height)
				endFill();
			}

		}
	}
}