package flashprolib.algoritms {
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class Zoomable {
		private var source:InteractiveObject
		private var target:InteractiveObject
		private var zoomIndicator:Sprite;
		private var zoomRect:Rectangle;
		public var enabled:Boolean=true
		public function Zoomable(source:InteractiveObject, target:InteractiveObject, zoomIndicator:Sprite) {
			this.source=source
			this.target=target
			this.zoomIndicator=zoomIndicator
			zoomRect=target.scrollRect
			setupListeners()
			setBaseState()
		}
		private function setupListeners():void {
			source.addEventListener(MouseEvent.MOUSE_OVER, evSourceOver)
			source.addEventListener(MouseEvent.MOUSE_OUT, evSourceOut)
			source.addEventListener(MouseEvent.MOUSE_MOVE, evSourceMove)
		}
		private function setBaseState():void {
			zoomIndicator.visible=target.visible=false
			zoomIndicator.mouseEnabled=false
		}
		private function evSourceOver(e:MouseEvent):void {
			if(enabled) {
				target.visible=zoomIndicator.visible=true;
				zoomIndicator.startDrag(true, new Rectangle(source.x, source.y, source.width, source.height))
			}
		}
		private function evSourceOut(e:MouseEvent):void {
			if(enabled) {
				target.visible=zoomIndicator.visible=false;
				zoomIndicator.stopDrag()
			}
		}
		private function evSourceMove(e:MouseEvent):void {
			if(enabled) {
				target.scrollRect=new Rectangle(source.mouseX / source.width * target.width, source.mouseY / source.height * target.height, zoomRect.width, zoomRect.height)
			}
		}
	}
}