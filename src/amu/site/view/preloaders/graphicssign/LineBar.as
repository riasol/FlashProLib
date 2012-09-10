package amu.site.view.preloaders.graphicssign
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class LineBar extends Sprite implements IBar
	{
		private var _barWidth:Number=150;
		private var _barHeight:Number=15;
		private var _color:Number=0xcccccc;
		private var _position:Point;
		public function LineBar()
		{
			super();
		}
		
		public function set barWidth(v:Number):void
		{
			_barWidth=v
		}
		
		public function set barHeight(v:Number):void
		{
			_barHeight=v
		}
		public function set color(v:Number):void
		{
			_color=v
		}
		public function set position(v:Point):void{
			_position=v
		}
		public function get position():Point{
			return _position
		}
		public function set percent(percentV:Number):void
		{
			var g:Graphics=graphics
			g.clear()
			//border
			g.lineStyle(1,_color,1)
			g.lineTo(_barWidth,0)
			g.lineTo(_barWidth,_barHeight)
			g.lineTo(0,_barHeight)
			g.lineTo(0,0)
			g.beginFill(_color)
			var pad:Number=2
			g.lineStyle(1,_color,0)
			g.moveTo(pad,pad)
			g.lineTo(pad+_barWidth*percentV-2*pad,pad);
			g.lineTo(pad+_barWidth*percentV-2*pad,_barHeight-pad/2);
			g.lineTo(pad,_barHeight-pad/2);
			g.endFill()
		}
		
	}
}