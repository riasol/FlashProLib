package flashprolib.util {
	import flash.utils.describeType;



	public class DataTransform {
		public function mapProperties(source:Object, dest:Class):* {
			var ret:*=new dest();
			var classInfo:XML=describeType(ret);
			for(var p:String in source) {
				for each(var dp:XML in classInfo..variable) {
					if(dp.@name == p) {
						ret[p]=source[p]
					}
				}
			}
			return ret;
		}
		public function mapArray(source:Array,pattern:Class):Array{
			var ret:Array=[]
			for each(var p:* in source){
				var maped:*=mapProperties(p,pattern)
				ret.push(maped);
			}
			return ret;
		}
		public function arrayObject2Array(inO:Object):Array {
			var ret:Array=[]
			var idx:uint=0
			while(true) {
				if(inO[idx]) {
					ret.push(inO[idx])
					idx++
				} else {
					break;
				}
			}
			return ret;
		}
		public function arrayObject2Object(inO:Object):Object {
			var ret:Object={}
			var idx:uint=0
			while(true) {
				if(inO[idx]) {
					ret[inO[idx].k]=inO[idx].v
					idx++
				} else {
					break;
				}
			}
			return ret;
		}
	}
}