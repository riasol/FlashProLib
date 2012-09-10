package amu.site.view.preloaders.graphicssign
{
	public class Config
	{
		public static var graphicsPath:String="/test/foto/prelo.png"
		public static var graphicsClass:Class;
		//[Bindable]
		//[Embed(source='../../../../../../../sites/domus/modules/assets/prelo_logo.png')]
		public static var bitmapClass:Class;
		public static var barClass:Class//=LineBar
		public static var barConfig:Object//={color:0xffffff,barWidth:100,barHeight:8,position:new Point(44,95)};
		public static var additionalBytes:Number=0
		public static var dispatchCompleteAfter:Number=1
	}
}