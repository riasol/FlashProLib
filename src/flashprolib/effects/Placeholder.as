package flashprolib.effects {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import flashprolib.util.DisplayUtils;

	public class Placeholder extends Sprite {
		private var _target:DisplayObjectContainer;
		public function Placeholder(target:DisplayObjectContainer,holderName:String) {
			super();
			_target=target;
			this.holderName=holderName
		}
		private var placeholder:Sprite;
		private var holderName:String;
		public function createPlace():Sprite{
			cleanup()
			placeholder=new Sprite()
			placeholder.name=holderName
			_target.addChild(placeholder)
			return placeholder
		}
		override public function addChild(child:DisplayObject):DisplayObject{
			return placeholder.addChild(child)
		} 
		public function cleanup():void {
			if(_target && placeholder) {
				DisplayUtils.removeAllChildren(placeholder)
				if(placeholder.parent!=null){
					_target.removeChild(placeholder)
				}
			}
		}

	}
}