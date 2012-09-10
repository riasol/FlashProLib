package test.graphics3d {
	import flash.display.Sprite;
	import flash.geom.Matrix3D;

	public class CartesianFlash extends Sprite {
		private var container:Sprite
		public function CartesianFlash() {
			super();
			container=new Sprite()
			addChild(container)
			drawAxes()
		}
		public var asexWidth:Number=100
		private function drawAxes():void {
			drawAxis(0, 0, 0,0xdd0000)
			drawAxis(0, 0, 90,0x00dd00)
			drawAxis(0, 90, 0,0x0000dd)
		}
		private function drawAxis(rx:Number, ry:Number, rz:Number,color:uint):void {
			var sprite:Sprite=new Sprite()
			with(sprite.graphics) {
				lineStyle(1, color)
				lineTo(asexWidth, 0)
				endFill()
			}
			container.addChild(sprite)
			sprite.rotationX=rx
			sprite.rotationY=ry
			sprite.rotationZ=rz
		}
	}
}
