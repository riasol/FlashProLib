package flashprolib.indicators.visualizers {
	import flash.filters.GlowFilter;

	public class VistaTypeVisualizerConfig extends IndicatorVisualizerConfig {
		public var textFormatColor:uint=0x000000;
		public var textFormatSize:uint=12;
		public var textFormatBold:Boolean=false;
		public var lineWidth:Number=5;
		public var diameter:Number=40;
		public var filters:Array
		public var color:uint=0xabe0f2
		function VistaTypeVisualizerConfig() {
			filters=[new GlowFilter(0xffffff, 0.8, 5, 5)]
		}
		private static var instance:VistaTypeVisualizerConfig;
		public static function getDefaultInstance():VistaTypeVisualizerConfig {
			if(instance == null) {
				instance=new VistaTypeVisualizerConfig()
			}
			return instance;
		}
	}
}