package flashprolib.flexx {

	import flash.display.Bitmap;

	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	[Style(name="glowColor", type="uint", format="Color", inherit="no")]
	[Style(name="icon", type="Class", inherit="no")]
	public class IconButton extends UIComponent {
		public function IconButton() {
			super();
		}
		private var iconChanged:Boolean
		override public function styleChanged(styleProp:String):void {
			super.styleChanged(styleProp);
			if(styleProp == 'icon') {
				iconChanged=true
				invalidateDisplayList();
			}
		}
		private var iconCont:UIComponent;
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			if(iconChanged) {
				iconChanged=false
				if(iconCont != null) {
					removeChild(iconCont)
				}
				iconCont=new UIComponent()
				addChild(iconCont)
				var BmpCLass:Class=Class(getStyle('icon'))
				var im:Bitmap=new BmpCLass()
				iconCont.addChild(im)
			}
		}

	}
}