package flashprolib.data {
	public class CaseInsensitiveSort {
		public var field:String
		public function CaseInsensitiveSort(field:String) {
			this.field=field;
		}
		public function sort(obj1:Object, obj2:Object):int {
			var obj1I:String=String(obj1[field]).toLowerCase()
			var obj2I:String=String(obj2[field]).toLowerCase()
			if(obj1I > obj2I) {
				return -1
			} else if(obj1I < obj2I) {
				return 1
			}
			return 0
		}
	}
}