package flashprolib.util {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;

	public class DisplayUtils {
		public static function removeAllChildren(dispObj:DisplayObjectContainer):void {
			if(dispObj is DisplayObjectContainer) {
				var cn:Number=dispObj.numChildren
				if(cn == 0) {
					return
				}
				for(var i:Number=cn - 1; i >= 0; i--) {
					dispObj.removeChildAt(i)
				}
			}
		}
		public static function buttonize(sprite:Sprite):void {
			sprite.mouseChildren=false
			sprite.buttonMode=true
		}
		/**
		 * Using:
		 * g.clear()
		 * DisplayUtils.prepareGradient(g,w,h)
		 * //g.drawRoundRect(0,0,w,h,2,2)
		 * //g.drawRect(0,0,w,h)
		 */
		public static function prepareGradient(
			g:Graphics
			, w:Number
			, h:Number
			, colors:Array=null
			, alphas:Array=null
			, ratios:Array=null
			, type:String=null
			, vertical:Boolean=false
			):void {
			if(colors == null) {
				colors=[0xcccccc, 0xffffff]
			}
			if(alphas == null) {
				alphas=[0.6, 0.4]
			}
			if(ratios == null) {
				ratios=[0, 0xFF]
			}
			if(type == null) {
				type=GradientType.LINEAR
			}
			var m:Matrix=new Matrix()
			var tx:Number=type == GradientType.RADIAL ? -w / 2 : 0
			var ty:Number=type == GradientType.RADIAL ? -h / 2 : 0
			m.createGradientBox(w, h, vertical ? Math.PI / 2 : 0, tx, ty)
			g.beginGradientFill(type, colors, alphas, ratios, m)
		}
		public static function drawBitmapGradient(g:Graphics, b:Bitmap, position:Rectangle):void {
			g.beginBitmapFill(b.bitmapData)
			g.drawRect(position.x, position.y, position.width, position.height)
			g.endFill()
		}
		public static function isAttached(dispO:DisplayObject):Boolean {
			if(dispO == null) {
				return false;
			}
			if(dispO.parent != null) {
				return true;
			}
			return false;
		}
		public static function cloneAsBitmap(source:DisplayObject, m:Matrix=null, transparent:Boolean=true, pixelSnapping:String=null, smothing:Boolean=true):Bitmap {
			pixelSnapping=pixelSnapping || PixelSnapping.NEVER
			var bmp:Bitmap
			var sc:Array=[1, 1]
			if(m != null) {
				sc=[m.a, m.d]
			}
			var bd:BitmapData=new BitmapData(source.width * sc[0], source.height * sc[0], transparent, 0x00000000)
			bd.draw(source, m)
			bmp=new Bitmap(bd, pixelSnapping, smothing)
			return bmp;
		}
		/**
		 * Replaces entire DisplayObject with bitmap
		 * TODO drawOnGraphics not working with scale9grid again
		 */
		public static function replaceAsBitmap(source:DisplayObject,drawOnGraphics:Boolean=false):DisplayObject {
			var bmp:DisplayObject;
			if(drawOnGraphics){
				var bmp0:Bitmap=cloneAsBitmap(source);
				bmp=new Shape();
				with(Shape(bmp).graphics){
					beginBitmapFill(bmp0.bitmapData)
					drawRect(0,0,bmp0.width,bmp0.height)
					endFill();
				}
			}else{
				bmp=cloneAsBitmap(source)
			}

			var parent:DisplayObjectContainer=source.parent
			var idx:uint=parent.getChildIndex(source)
			bmp.x=source.x;
			bmp.y=source.y;
			parent.addChild(bmp)
			parent.removeChild(source)
			parent.setChildIndex(bmp, idx)
			return bmp;
		}

		/**
		 * Center sprite to regard
		 */
		public static function center(sprite:DisplayObject, regard:DisplayObject):void {
			var regardDim:Array
			if(regard is Stage) {
				regardDim=[Stage(regard).stageWidth, Stage(regard).stageHeight]
			} else {
				regardDim=[regard.width, regard.height]
			}
			sprite.x=regardDim[0] / 2 - sprite.width / 2;
			sprite.y=regardDim[1] / 2 - sprite.height / 2;
		}
		/**
		 * containerSize 2 or 4 el, 4 for x,y
		 * obj can be DisplayObject
		 */
		public static function centerAbstract(objSize:Array, containerSize:Array, obj:Object=null):Object {
			if(obj == null) {
				obj={}
			}
			obj.x=(containerSize[0] - objSize[0]) / 2;
			obj.y=(containerSize[1] - objSize[1]) / 2;
			if(containerSize.length == 4) {
				obj.x+=containerSize[2]
				obj.y+=containerSize[3]
			}
			return obj
		}
		/**
		 * @param vpRect viewport rect
		 * @param  vRect content rect
		 * @param position Position in vpRect
		 * @param pad left/right padding
		 */
		public static function zoomProjection(vpRect:Rectangle, vRect:Rectangle, position:Point, pad:Number=0):Point {
			var ret:Point=new Point()
			ret.x=pad - (vRect.width - vpRect.width + pad) * position.x / vpRect.width
			if(ret.x > 0) {
				ret.x=0
			} else if(ret.x < -(vRect.width - vpRect.width)) {
				ret.x=-vRect.width - vpRect.width
			}
			return ret
		}
		/**
		 * Znajduje taką skale aby krawędzie nie wychodziły poza rozmiar requiredSize
		 * @param cSize Current size
		 */
		public static function noOverScale(currentSize:Array, requiredSize:Array):Number {
			return Math.min(requiredSize[0] / currentSize[0], requiredSize[1] / currentSize[1])
		}
		public static function drawTriangle(g:Graphics, w:Number, h:Number):void {
			g.moveTo(w / 2, h / 2);
			g.lineTo(-w / 2, h / 2);
			g.lineTo(0, -h / 2);
			g.endFill();
		}
		public static function toARGB(rgb:uint, newAlpha:uint):uint {
			var argb:uint=0;
			argb=(rgb);
			argb+=(newAlpha << 24);
			return argb;
		}

		public static function toRGB(argb:uint):uint {
			var rgb:uint=0;
			rgb=(argb & 0xFFFFFF);
			return rgb;
		}
		/**
		 * http://blog.circlecube.com/2008/10/tutorial/colortransform-rgb-hex-and-random-colors-actionscript-color-tutorial/
		 */
		public static function hex2rgb(hex:uint):Object {
			var red:Number=hex >> 16;
			var greenBlue:Number=hex - (red << 16)
			var green:Number=greenBlue >> 8;
			var blue:Number=greenBlue - (green << 8);
			return ({r:red, g:green, b:blue});
		}
		/**
		 * wg asdoc tworzy filtrowaną wersje BitmapData w BitmapData
		 */
		public static function applyFilter(source:BitmapData, filter:BitmapFilter):void {
			source.applyFilter(source, source.rect, new Point(), filter);
		}
		public static function colorize(target:DisplayObject, color:uint, amount:Number=1):void {
			var rgb:Object=hex2rgb(color)
			//trace(rgb.r+' '+rgb.g+' '+rgb.b)
			//target.transform.colorTransform=new ColorTransform(0,0,0,1,-255,-255,-255,0)//zeroe
			target.transform.colorTransform=new ColorTransform(1 - amount, 1 - amount, 1 - amount, 1, Math.round(rgb.r * amount), Math.round(rgb.g * amount), Math.round(rgb.b * amount), 0)
		}
		/**
		 * shortcut
		 */
		static public function copyChannel(source:BitmapData, dest:BitmapData, channel:uint):void {
			dest.copyChannel(source, source.rect, new Point(), channel, channel);
		}
		public static function createOverStageZone(target:DisplayObjectContainer):Sprite {
			if(target.getChildByName('overStageZone') != null) {
				target.removeChild(target.getChildByName('overStageZone'))
			}
			var p:Point=new Point()
			var p2:Point=target.localToGlobal(p)
			var ret:Sprite=new Sprite()
			ret.graphics.beginFill(0x000000, 0)
			ret.graphics.drawRect(-p2.x, -p2.y, target.stage.stageWidth, target.stage.stageHeight)
			ret.graphics.endFill()
			ret.name='overStageZone'
			ret.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				e.stopPropagation()
			}, false, 0, true);
			target.addChild(ret)
			return ret
		}

	}
}
