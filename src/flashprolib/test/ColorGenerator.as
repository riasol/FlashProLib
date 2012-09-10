package flashprolib.test {
	
	import flashprolib.util.MathExtensions;
	
	import mx.utils.ColorUtil;

	public class ColorGenerator {
		public function randomColor(r:uint,g:uint,b:uint,a:uint=1):uint {
				if(r===0)
			r=MathExtensions.randomInRange(0,255)
				if(g===0)
			g=MathExtensions.randomInRange(0,255)
				if(b===0)
			b=MathExtensions.randomInRange(0,255)
			return (r<<16) | (g<<8) | b
		}
	}
}