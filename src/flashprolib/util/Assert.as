package flashprolib.util {

	public class Assert {
		/*
			compiler directive:
			-define+=CONFIG::debug,true
			using:
			CONFIG::debug { Assert.assert(someVar != null) }
		 */
		CONFIG::debug
		public static function assert(condition:Boolean, message:String='assert'):void {
			if(!condition) {
				throw new Error(message)
			}
		}
	}
}