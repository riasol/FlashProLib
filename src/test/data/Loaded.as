package test.data
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public class Loaded extends Sprite
	{
		public var objectVersion:String='v0'
		public function Loaded()
		{
			super();
			var tf:TextField=new TextField()
			tf.text='jestem Sprite'
			addChild(tf)
		}
		
	}
}