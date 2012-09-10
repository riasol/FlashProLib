package flashprolib.effects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import flashprolib.util.DisplayUtils;
	import flashprolib.util.MathExtensions;
	import flashprolib.util.MatrixTransformer;
	

	public class ReflectionEffect implements IFPEffect{
		private var _target:DisplayObjectContainer
		private var holder:Placeholder
		function ReflectionEffect(target:DisplayObjectContainer){
			_target=target as DisplayObjectContainer;
			holder=new Placeholder(target,'ReflectionEffectHolder');
			applyEffect()
		}
		private var _distance:Number=5
		public function set distance(v:Number):void{
			_distance=v
			applyEffect()
		}
		public function get distance():Number{
			return _distance
		}
		private var _percentHeight:Number=40;
		/**
		 * percent of target object height
		 */ 
		public function set percentHeight(v:Number):void{
			_percentHeight=v
			applyEffect()
		}
		public function get percentHeight():Number{
			return _percentHeight
		}
		private var _skew:Number=30
		public function set skew(v:Number):void{
			_skew=v
			applyEffect()
		}
		public function get skew():Number{
			return _skew
		}
		private var bd:BitmapData
		private function applyEffect():void{
			var destination:Sprite=holder.createPlace()
			//trace(_target.height)
			var origH:Number=_target.height
			var drawedH:Number= origH*percentHeight/100
			
			var dX:Number=Math.tan(MathExtensions.deg2rad(skew))*origH
			
			var m:Matrix=new Matrix();
			MatrixTransformer.skew(m,skew+180,'bottom')
			m.scale(1,percentHeight/100)
			bd=new BitmapData(_target.width+Math.tan(MathExtensions.deg2rad(skew))*_target.width, _target.height, true, 0x00000000)
			bd.draw(_target,m,null,null,null,true)
			var alphaMaskTarget:Sprite=new Sprite()
			DisplayUtils.prepareGradient(alphaMaskTarget.graphics,bd.width,drawedH,[0x000000,0x000000],[0,1],[0,200],null,true)
			alphaMaskTarget.graphics.drawRect(0,0,bd.width,drawedH)
			var alphaMask:BitmapData=new BitmapData(bd.width,drawedH, true, 0x00000000)
			alphaMask.draw(alphaMaskTarget)
			var masked:BitmapData=new BitmapData(bd.width,drawedH, true, 0x00000000)
			masked.copyPixels(bd,bd.rect,new Point(),alphaMask,new Point(),true)
			var b:Bitmap=new Bitmap(masked.clone(),PixelSnapping.NEVER,true)
			bd.dispose()
			masked.dispose()
			alphaMask.dispose()
			destination.addChild(b)
			b.scaleY=-1
			destination.x=-dX
			destination.y=origH+distance+drawedH
		}
		public function set target(v:Object):void{
			_target=v as DisplayObjectContainer
		}
		public function get target():Object{
			return _target
		}
	}
}