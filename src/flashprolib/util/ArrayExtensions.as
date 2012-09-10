package flashprolib.util
{

	public class ArrayExtensions
	{
		public static function fill(inArr:Array,callback:Function,count:uint,start:uint=0):void{
			for(var i:uint=start;i<start+count;i++){
				inArr[i]=callback.call()
			}
		}
	}
}