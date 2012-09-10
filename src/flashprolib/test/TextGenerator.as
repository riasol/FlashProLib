package flashprolib.test {
	import flashprolib.util.MathExtensions;

	public class TextGenerator {
		public function randomText(length:uint):String {
			var ret:String=''
			for(var i:uint=0; i < length; i++) {
				ret+=getChar()
				if(MathExtensions.randomInRange(0, 20, true) == 0) {
					ret+=" "
					i++
				}
			}
			return ret
		}
		private function getChar():String{
			return String.fromCharCode(MathExtensions.randomInRange(65, 122, true))
		}
		public function getWords(num:uint,minLength:uint=5,maxLength:uint=10):Array{
				var ar:Array=[]
				for(var i:uint=0;i<num;i++){
					var wCnt:uint=MathExtensions.randomInRange(minLength,maxLength,true)
					var word:String=''
						for(var j:uint=0;j<wCnt;j++){
							word+=getChar()
						}
					ar.push(word)
				}
				return ar
		}
	}
}