package flashprolib.indicators.visualizers{
	public class CircleIndicatorConfig extends IndicatorVisualizerConfig{
		/** Promień okręgu
		 * */
		public var r:Number=9;
		/** Promień kuleczki
		 * */
		public var circleR:Number=1.5;
		public var fillColor:uint=0xcccccc;
		public var glowColor:uint=0xcccccc;
		private static var instance:CircleIndicatorConfig;
		public static function getInstance():CircleIndicatorConfig {
			if(instance == null) {
				instance=new CircleIndicatorConfig()
			}
			return instance;
		}

	}

}