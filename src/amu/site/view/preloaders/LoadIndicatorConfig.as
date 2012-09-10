package amu.site.view.preloaders {
	/**
	 * Domyślne ustawienia dla indykatora
	 * LoadIndicatorConfig.getInstance().r=..
	 * LoadIndicatorConfig.getInstance().configChanged=true
	 */
	public class LoadIndicatorConfig {
		public var x:Number;
		public var y:Number;
		/** Promień okręgu */
		public var r:Number=9;
		/** Promień kuleczki */
		public var circleR:Number=1.5
		public var fillColor:uint=0xcccccc;
		public var glowColor:uint=0xcccccc;
		/**
		 * Dla zgodności z wdrożonymi loaderami, nalezy ustawiać jęśli modyfikuje się ustawienia
		 */
		public var configChanged:Boolean=false;
		private static var instance:LoadIndicatorConfig;
		public static function getInstance():LoadIndicatorConfig {
			if(instance == null) {
				instance=new LoadIndicatorConfig()
			}
			return instance;
		}

	}

}