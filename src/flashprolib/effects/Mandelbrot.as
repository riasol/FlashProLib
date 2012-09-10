package flashprolib.effects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class Mandelbrot extends Sprite {
		public function Mandelbrot() {
			super();
		}
		private var _generateWidth:Number=250
		public function get generateWidth():Number {
			return _generateWidth;
		}

		public function set generateWidth(value:Number):void {
			_generateWidth=value;
			update()
		}
		private var _generateHeight:Number=250
		public function get generateHeight():Number {
			return _generateHeight;
		}

		public function set generateHeight(value:Number):void {
			_generateHeight=value;
			update()
		}
		private var _iterationCount:uint=8

		public function get iterationCount():uint {
			return _iterationCount;
		}

		public function set iterationCount(value:uint):void {
			_iterationCount=value;
			update()
		}
		private var _blankColour:uint=0x000000

		public function get blankColour():uint {
			return _blankColour;
		}

		public function set blankColour(value:uint):void {
			_blankColour=value;
			update()
		}
		private var drawBitmap:Bitmap;
		public var lazy:Boolean=true
		public function update(force:Boolean=false):void {
			if(!force && lazy) {
				return
			}
			if(drawBitmap is Bitmap) {
				removeChild(drawBitmap)
			}
			drawBitmap=new Bitmap()
			addChild(drawBitmap)
			var bData:BitmapData=new BitmapData(generateWidth, generateHeight)
			drawBitmap.bitmapData=bData;
			bData.lock()
			for(var i:uint=0; i < generateWidth; i++) {
				for(var j:uint=0; j < generateHeight; j++) {
					var n:Number=0
					var ni:Number=0
					for(var k:uint=0; k < iterationCount; k++) {
						var nn:Number=Math.pow(n, 2) - Math.pow(ni, 2) + i;
						var nni:Number=2 * n * ni + j;
						n=nn
						ni=nni
							if((Math.pow(n,2)+Math.pow(ni,2))>4){
							bData.setPixel(i,j,0x000000)
								//break
							}else{
							var colSc:Number=k/iterationCount*255
								var rv:uint= colSc  << 16
								var gv:uint=(colSc+50) << 8
								var bv:uint=colSc 
								bData.setPixel(i,j,rv | gv | bv)
							}
					}
				}
			}
			bData.unlock()
		}
	}
}