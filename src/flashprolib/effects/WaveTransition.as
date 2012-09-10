package flashprolib.effects {
	import caurina.transitions.Tweener;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;

	import flashprolib.util.DisplayUtils;

	public class WaveTransition extends FPTransition {
		private var holder:Placeholder
		private var gradient:BitmapData
		private var perlinNoise:BitmapData
		private var perlinSeed:int;
		private var perlinOffsets:Array
		private var originalBD:BitmapData
		private var destBitmap:Bitmap
		public var windRateStart:Number=0
		public var windRateFinish:Number=30
		private var _windRate:Number=30
		public function set windRate(v:Number):void {
			_windRate=v
			wave()
		}
		public function get windRate():Number {
			return _windRate
		}
		public function WaveTransition() {
			super()
		}
		private var _target:DisplayObjectContainer
		override public function set target(v:Object):void {
			_target=v as DisplayObjectContainer
			cleanup()
		}
		private var _destination:DisplayObjectContainer
public function set destination(v:Object):void {
			_destination=v as DisplayObjectContainer
			cleanup()
			createFields()
		}
		override public function get target():Object {
			return null;
		}

		override public function play():void {
			Tweener.addTween(this, {windRate:windRateFinish, time:duration
			,onCompleteScope:this
			,onComplete:cleanup
			})
		}

		override public function stop():void {
			cleanup()
		}
		private function cleanup():void {
			if(holder) {
				holder.cleanup()
			}
			Tweener.removeTweens(this)
			_target.visible=true
		}
		private function createFields():void {
			var matrix:Matrix=new Matrix();
			matrix.createGradientBox(_target.width, _target.height)
			var shape:Shape=new Shape();
			shape.graphics.beginGradientFill(
				GradientType.LINEAR,
				[0x7F7F7F, 0x7F7F7F],
				[1, 0],
				[20, 80],
				matrix
				);
			shape.graphics.drawRect(0, 0, _target.width, _target.height);
			shape.graphics.endFill();
			gradient=new BitmapData(_target.width, _target.height, true, 0x00000000)
			gradient.draw(shape)
			perlinNoise=new BitmapData(_target.width, _target.height)
			perlinSeed=int(new Date());
			perlinOffsets=[new Point()];
			originalBD=new BitmapData(_target.width, _target.height, true, 0x00000000)
			originalBD.draw(_target)
			holder=new Placeholder(_destination, 'WaveTransition')
			holder.createPlace()
			destBitmap=new Bitmap(null, PixelSnapping.NEVER, true)
			holder.addChild(destBitmap)
			_target.visible=false
		}

		private function wave():void {
			var bdClone:BitmapData=originalBD.clone()
			perlinNoise.perlinNoise(
				200,
				200,
				1,
				perlinSeed,
				false,
				true,
				BitmapDataChannel.RED,
				true,
				perlinOffsets
				);
			(perlinOffsets[0] as Point).x-=windRate;
			DisplayUtils.applyFilter(bdClone, new DisplacementMapFilter(
				perlinNoise,
				new Point(),
				BitmapDataChannel.RED,
				BitmapDataChannel.RED,
				40,
				60
				));
			DisplayUtils.copyChannel(bdClone, perlinNoise, BitmapDataChannel.ALPHA)
			bdClone.draw(
				perlinNoise,
				null,
				new ColorTransform(1, 1, 1, 0.5),
				BlendMode.HARDLIGHT
				);
			destBitmap.bitmapData=bdClone
		}
	}
}