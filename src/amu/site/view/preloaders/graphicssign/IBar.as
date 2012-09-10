package amu.site.view.preloaders.graphicssign
{
	import flash.geom.Point;
	
	public interface IBar
	{
		function set barWidth(v:Number):void
		function set barHeight(v:Number):void
		function set percent(v:Number):void
		function set color(v:Number):void
		function set position(v:Point):void
		function get position():Point
	}
}