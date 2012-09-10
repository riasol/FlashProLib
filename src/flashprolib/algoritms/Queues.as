package flashprolib.algoritms {
	public class Queues {
		/**
		 * Indeks krążący czyli jeśli powyżej ostatniego elementu to wraca na 0, jeśli poniżej zerowego na ostatni
		 * jako mx podawać length-1
		 */
		public static function circulus(idx:int, direction:int, max:uint):uint {
			idx+=direction
			if(idx < 0) {
				idx=max
			}
			if(idx > max) {
				idx=0
			}
			return idx
		}
	}
}