package flashprolib.flexx.spark
{
	import flash.geom.Rectangle;
	
	import spark.components.supportClasses.ButtonBase;
	import spark.primitives.BitmapImage;
	
	public class SparkImageButton extends ButtonBase
	{
		public function SparkImageButton(){
			super();
			setStyle('skinClass',SparkImageButtonSkin)
			
		}
		[Bindable]
		private var _image:Class;

		public function get image():Class
		{
			return _image;
		}

		public function set image(value:Class):void
		{
			_image = value;
			if(imageDisplay!=null){
				imageDisplay.source=_image;
			}
		}
		override protected function partAdded(partName:String, instance:Object):void { 
			super.partAdded(partName, instance); 
			if(instance==imageDisplay && image!=null){
				imageDisplay.source=image;
			}
		}
		[SkinPart(required='true')]
		public var imageDisplay:BitmapImage;
		override public function invalidateSize():void{
			super.invalidateSize()
			if(skin !=null){//trace(height)
				skin.scrollRect=new Rectangle(0,0,width,height)
			}
		}
	}
}