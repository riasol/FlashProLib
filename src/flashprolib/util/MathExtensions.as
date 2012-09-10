package flashprolib.util {

	public class MathExtensions {
		/**
		 * @var last Previous, used to select numbers without repeating
		 */
		public static function randomInRange(min:Number, max:Number, round:Boolean=false,last:Number=NaN):Number {
			var res:Number=min + (max - min) * Math.abs(Math.random());
			if(round) {
				res=Math.round(res)
			}
			if(!isNaN(last) && res==last){
				res=MathExtensions.randomInRange(min,max,round,last)
			}
			return res;
		}
		;
		public static function randomBoolean():Boolean {
			return Math.round(Math.random()) == 0
		}
		public static function randomSign():int {
			return Math.round(Math.random()) == 0?1:-1
		}
		public static function rad2deg(pi:Number):Number {
			return 180 * pi / Math.PI;
		}
		;
		public static function deg2rad(deg:Number):Number {
			return Math.PI * deg / 180;
		}
		/**
		 * TODO Test
		 * @return absolute minimum regardless number sign
		 * eg: -3,2 -> 2
		 */
		public static function absMin(v:Number, v2:Number):Number {
			v=Math.abs(v)
			v2=Math.abs(v2)
			return Math.min(v, v2);
		}

		public static function absMax(v:Number, v2:Number):Number {
			v=Math.abs(v)
			v2=Math.abs(v2)
			return Math.max(v, v2);
		}
		;
		public static function average(values:Array):Number {
			if(values.length == 0) {
				return 0
			}
			var sum:Number=0;
			for each(var n:Number in values) {
				sum+=n
			}
			return sum / values.length
		}
		;
		public static function stdDeviation(expected:Number, values:Array):Number {
			if(values.length == 0) {
				return 0
			}
			var sum:Number=0;
			for each(var n:Number in values) {
				sum+=Math.pow(n - expected, 2)
			}
			return Math.sqrt(sum / values.length)
		}
		;
		public static function angle(x:Number, y:Number):Number {
			var angleDeg:Number=rad2deg(Math.atan2(y, x))
			if((x < 0 && y < 0) || (x > 0 && y < 0)) {
				angleDeg=360 + angleDeg
			}
			return angleDeg
		}
		;
		public static function arraySum(values:Array):Number {
			var ret:Number=0
			for each(var n:Number in values) {
				ret+=n;
			}
			return ret;
		}
		public static function signChanged(values:Array):Boolean {
			if(values.length < 2) {
				return false
			}
			if(values[values.length - 1] < 0 && values[values.length - 2] > 0) {
				return true
			}
			if(values[values.length - 1] > 0 && values[values.length - 2] < 0) {
				return true
			}
			return false
		}
		public static function directionChanged(values:Array):Boolean {
			if(values.length < 3) {
				return false
			}
			var diffs:Array=[values[values.length - 1]-values[values.length - 2],values[values.length - 2]-values[values.length - 3]]
			return signChanged(diffs)
		}
	}
}