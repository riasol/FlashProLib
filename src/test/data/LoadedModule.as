package test.data
{
	
	import mx.controls.Label;
	import mx.modules.Module;

	public class LoadedModule extends Module
	{
		public var objectVersion:String='v0'
		public function LoadedModule()
		{
			super();
			var tf:Label=new Label()
			tf.text='jestem Module'
			addChild(tf)
		}
		
	}
}