package flashprolib.algoritms {
	public class Physics {
		/** 
		 * przemieszczenie w ruchu grawitacyjnym
		 * http://pl.wikipedia.org/wiki/Kinematyczne_r%C3%B3wnanie_ruchu
		* Ruch prostoliniowy jednostajnie przyspieszony 
		* (x0 – położenie początkowe, v0 - prędkość początkowa, a – przyspieszenie)
		 **/
		public static function sGravity(t:Number,s0:Number,v0:Number,a:Number=10):Number {
			return s0+v0*t+1/2*a*Math.pow(t,2);
		}
	}
}