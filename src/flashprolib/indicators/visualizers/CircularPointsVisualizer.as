package flashprolib.indicators.visualizers {
	import flash.display.Sprite;
	import flash.filters.GlowFilter;

	import flashprolib.indicators.LoadVO;

	public class CircularPointsVisualizer extends AbstractIndicatorVisualizer {
		private var pointScale:Number;
		private var maxParts:int
		private var ptr:int
		private var config:CircleIndicatorConfig
		function CircularPointsVisualizer(c:Class) {
			super(c);
			if(c != null) {
				config=new c()
			}else{
				config=CircleIndicatorConfig.getInstance()
			}
			createChildren()
		}
		private function createChildren():void {
			alpha=0
			pointScale=360 * 3 * config.circleR / (2 * Math.PI * config.r)
			maxParts=Math.round(360 / pointScale)
			filters=[new GlowFilter(config.glowColor, 1, 5, 5, 1, 1)]
			ptr=0;
			var step:Number=360 / maxParts
			for(var i:int=0; i < maxParts; i++) {
				var pointIndicator:Sprite=new Sprite()
				addChild(pointIndicator)
				pointIndicator.x=config.r * Math.cos(step * i * 2 * Math.PI / 360)
				pointIndicator.y=config.r * Math.sin(step * i * 2 * Math.PI / 360)
				pointIndicator.graphics.lineStyle(1, 0x000000, 0)
				pointIndicator.graphics.beginFill(config.fillColor)
				pointIndicator.graphics.drawCircle(0, 0, config.circleR)
				pointIndicator.graphics.endFill()
			}
		}
		override public function update(vo:LoadVO):void {
			var used:int=10
			alpha=Math.min(alpha + 0.05, 1)
			for(var i:int=0; i < maxParts; i++) {
				var cIdx:int=i - used / 2
				if(cIdx < 0) {
					cIdx=maxParts + cIdx
				}
				if(i > ptr - used / 2 && i < ptr + used / 2) {
					getChildAt(cIdx).alpha=Math.abs(i - ptr) / (used / 2)
				} else {
					getChildAt(cIdx).alpha=1
				}
			}
			ptr++
			if(ptr == maxParts) {
				ptr=0
			}
		}
	}
}