package flashprolib.indicators.visualizers {
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	import flashprolib.indicators.LoadVO;

	public class VistaTypeVisualizer extends AbstractIndicatorVisualizer {
		private var config:VistaTypeVisualizerConfig
		public function VistaTypeVisualizer(c:Class=null) {
			super(c);
			if(c != null) {
				config=new c()
			} else {
				config=VistaTypeVisualizerConfig.getDefaultInstance()
			}
			createChildren()
		}
		private var tf:TextField;
		private var circle:Sprite
		private function createChildren():void {
			alpha=0
			tf=new TextField()
			addChild(tf)
			tf.selectable=false
			var tfm:TextFormat=tf.defaultTextFormat
			tfm.bold=config.textFormatBold
			tfm.color=config.textFormatColor
			tfm.size=config.textFormatSize
			tfm.align=TextFormatAlign.CENTER
			tfm.font='_sans'
			tf.defaultTextFormat=tfm
			tf.width=30
			tf.x=-1 * tf.width / 2
			tf.height=config.textFormatSize * 1.4
			tf.y=-1 * tf.height / 2
			circle=new Sprite()
			addChild(circle)
			var gradientBoxMatrix:Matrix=new Matrix();
			gradientBoxMatrix.createGradientBox(config.diameter / 2, config.diameter, 0, 0, 0);
			circle.graphics.lineStyle(config.lineWidth, 1)
			circle.graphics.lineGradientStyle(GradientType.LINEAR, [config.color, config.color], [1, 0.2], [0, 255], gradientBoxMatrix)
			circle.graphics.beginFill(0x000000, 0)
			circle.graphics.drawCircle(0, 0, config.diameter / 2)
			filters=config.filters
		}
		override public function update(vo:LoadVO):void {
			if(vo.bt > 0) {
				tf.text=String(Math.round(vo.bl / vo.bt* 100) )
			} else {
				tf.text='...'
			}

			alpha=Math.min(alpha + 0.05, 1)
			circle.rotation+=3
		}
	}
}