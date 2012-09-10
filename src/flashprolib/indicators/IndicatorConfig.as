package flashprolib.indicators {
	import flashprolib.util.CoreUtils;

	public class IndicatorConfig {
		public var x:Number;
		public var y:Number;
		/**
		 * @var AbstractIndicatorVisualizer
		 */
		public var visualizerClass:Class;
		/**
		 * @var IndicatorVisualizerConfig
		 */
		public var visualizerConfigClass:Class;
		public var oneInstanceVisible:Boolean;
		private static var instance:IndicatorConfig;
		public static function getDefaultInstance():IndicatorConfig {
			if(instance == null) {
				instance=new IndicatorConfig()
			}
			return instance;
		}
		public function clone():IndicatorConfig{
			//var ret:IndicatorConfig=CoreUtils.clone(this) TODO
			var ret:IndicatorConfig=new IndicatorConfig()
			ret.x=x
			ret.y=y
			ret.visualizerClass=visualizerClass
			ret.visualizerConfigClass=visualizerConfigClass
			ret.oneInstanceVisible=oneInstanceVisible
			return ret
		}
	}

}