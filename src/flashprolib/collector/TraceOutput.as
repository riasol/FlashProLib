package flashprolib.collector {
	public class TraceOutput  implements ICollectionOutput{
		private var outputFormat:String=OUTPUT_FORMAT_FREEMAT;
		public static const OUTPUT_FORMAT_FREEMAT:String='OUTPUT_FORMAT_FREEMAT'
		public function TraceOutput() {
		}
		public function print(inp:Array):void {
			var str:String
			switch(outputFormat) {
				case OUTPUT_FORMAT_FREEMAT:
					str=formatFreematRow(inp)
					break;
			}
			trace(str)
		}
		private function formatFreematRow(inp:Array):String {
			var points:Array=[]
			for each(var o:Object in inp) {
				if(o is Number) {
					points.push(o)
				}
			}
			return '['+points.join(',')+']'
		}
	}
}