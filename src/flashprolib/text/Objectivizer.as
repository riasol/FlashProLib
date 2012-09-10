package flashprolib.text {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import flashprolib.util.CoreUtils;

	public class Objectivizer {
		public static const SPLIT_BY_CHAR:uint=0;
		public static const SPLIT_BY_WORD:uint=1;
		public static const SPLIT_BY_LINE:uint=2;
		public static const SPLIT_BY_PARAGRAPH:uint=3;
		private var _splitBy:uint=SPLIT_BY_CHAR;
		private var _container:DisplayObjectContainer;
		private var _sourceTextField:TextField;
		private var _elements:Array;

		public function Objectivizer(tf:TextField) {
			_sourceTextField=tf;
			_elements=[]
		}

		public function set splitBy(v:uint):void {
			_splitBy=v
		}

		public function objectivize():void {
			if (_container == null) {
				_container=new Sprite()
				_container.x=_sourceTextField.x;
				_container.y=_sourceTextField.y;
				_sourceTextField.parent.addChild(_container)
			}
			switch (_splitBy) {
				case SPLIT_BY_CHAR:
					splitByChar()
					break;
				case SPLIT_BY_WORD:
					splitByWord()
					break;
			}
			_sourceTextField.visible=false
		}

		public function set container(c:DisplayObjectContainer):void {
			_container=null
			_container=c
		}

		private function splitByChar():void {
			var l:int=_sourceTextField.text.length
			for (var i:uint=0; i < l; i++) {
				var ch:String=_sourceTextField.text.charAt(i)
				if (ch == "\r" || ch == "\n") {
					continue
				}
				var tf:Sprite=cloneTextField(ch)
				var b:Rectangle=_sourceTextField.getCharBoundaries(i)
				if (b is Rectangle) {
					tf.x=b.x;
					tf.y=b.y;
				}
			}
		}
		private function splitByWord():void {
			var words:Array=_sourceTextField.text.split(' ')
			var l:int=words.length
			var startIndex:int=0;
			for (var i:uint=0; i < l; i++) {
				var curWordL:int=words[i].length
				words[i]=String(words[i]).replace(/\r|\n/g,'')
				var tf:Sprite=cloneTextField(words[i])
				var b:Rectangle=_sourceTextField.getCharBoundaries(startIndex)
				startIndex+=curWordL+1
				if (b is Rectangle) {
					tf.x=b.x;
					tf.y=b.y;
				}
			}
		}

		private function cloneTextField(text:String):Sprite {
			var newTf:TextField=new TextField()
			newTf.name='textElement'
			newTf.multiline=false;
			newTf.autoSize=TextFieldAutoSize.LEFT;
			newTf.defaultTextFormat=_sourceTextField.getTextFormat()
			CoreUtils.copyObjectProperties(_sourceTextField, newTf, 'selectable antiAliasType background backgroundColor border borderColor embedFonts gridFitType sharpness styleSheet textColor textColor thickness')
			newTf.text=text
			var sp:Sprite=new Sprite()
			_elements.push(sp)
			var bd:BitmapData=new BitmapData(newTf.width,newTf.height,true,0x00000000)
			bd.draw(newTf)//,null,null,null,null,true
			sp.addChild(new Bitmap(bd,PixelSnapping.NEVER,true))
			_container.addChild(sp)
			return sp;
		}

		public function getElementAt(idx:uint):Sprite {
			return _elements[idx] as Sprite
		}

		public function get elementsCount():uint {
			return _elements.length
		}
	}
}