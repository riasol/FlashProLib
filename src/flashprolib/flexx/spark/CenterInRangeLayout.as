package flashprolib.flexx.spark {
	import mx.core.IVisualElement;

	import spark.layouts.supportClasses.LayoutBase;

	public class CenterInRangeLayout extends LayoutBase {
		public function CenterInRangeLayout() {
			super();
		}
		public var paddingTopMax:Number=0
		override public function updateDisplayList(containerWidth:Number, containerHeight:Number):void {
			if(target.numElements > 0) {
				var el0:IVisualElement=target.getElementAt(0);
				el0.x=containerWidth / 2 - el0.width / 2
				el0.y=Math.min(containerHeight / 2 - el0.height / 2, paddingTopMax)
			}
		}
	}
}