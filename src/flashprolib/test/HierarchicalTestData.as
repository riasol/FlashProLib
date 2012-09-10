package flashprolib.test {
	import flashprolib.util.MathExtensions;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;

	public class HierarchicalTestData implements ITestDataProvider {
		public var levels:uint=2;
		public var TemplateVOClass:Class=DummyItem;
		/**
		 * Length of level
		 */
		public var maxLength:uint=10;
		public function HierarchicalTestData() {
		}

		public function generate():ICollectionView {

			var ar:Array=new Array()
			generateLevel(ar, 0, maxLength)
			return new ArrayCollection(ar);
		}
		private function generateLevel(ar:Array, deep:uint, subLength:uint):void {
			for(var i:uint=0; i < subLength; i++) {
				var item:Object=new TemplateVOClass() 
				if(deep < levels) {
					item.children=[]
					generateLevel(item.children, deep + 1, i)
				}
				ar.push(item)
			}
		}
	}
}