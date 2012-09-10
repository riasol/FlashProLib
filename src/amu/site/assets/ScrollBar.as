package amu.site.assets{
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	public class ScrollBar extends Sprite{
		public var minusArrow:DisplayObject;//Był SimpleButton
		public var plusArrow:DisplayObject;
		public var knob:Sprite;
		//mc na normalnej warstwie, do użycia jako maska, może być większa i do niczego nie służyć
		public var knobMask:Sprite;
		//Dla DnD
		public var knobLimits:Sprite;
	}
}