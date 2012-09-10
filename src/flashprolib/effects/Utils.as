package flashprolib.effects {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class Utils {
		private var removedChildren:Array;
		public function Utils() {

		}

		public function removeChildren(doc:DisplayObjectContainer):void {
			removedChildren=[]
			for(var i:int=doc.numChildren - 1; i >= 0; i--) {
				removedChildren.push(doc.getChildAt(i))
				doc.removeChildAt(i)
			}
		}
		public function attachChildren(doc:DisplayObjectContainer):void {
			for each(var remChild:DisplayObject in removedChildren) {
				doc.addChild(remChild)
			}
		}
	}
}