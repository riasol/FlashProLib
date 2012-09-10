package flashprolib.debug {
	import flash.display.Sprite;
	import flash.text.TextField;

	public class DebugTextField extends DebugTextFieldStub {
		var tf:TextField
		public function DebugTextField() {
			super();
			tf=new TextField()
			addChild(tf)
		}
		override public function set text(t:*):void {
			tf.text=String(t)
		}
	}
}