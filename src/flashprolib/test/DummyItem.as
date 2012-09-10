package flashprolib.test
{
	import flashprolib.util.MathExtensions;
[Bindable]
	public class DummyItem
	{
		public var label:String;
		public var id:int;
		public var children:Array
		public function DummyItem()
		{
			label=new TextGenerator().randomText(30)
				id=MathExtensions.randomInRange(0,1000,true)
		}
		
	}
}