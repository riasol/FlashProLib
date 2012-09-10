package flashprolib.locale {
	public class StringsPL {
		public static var weekDaysShort:Array=['Pn', 'Wt', 'Śr', 'Cz', 'Pt', 'Sb', 'Nd']
		public static var weekDays:Array=['Poniedziałek', 'Wtorek', 'Środa', 'Czwartek', 'Piątek', 'Sobota', 'Niedziela']
		public static var months:Array=['Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec', 'Lipiec', 'Sierpień', 'Wrzesień', 'Październik', 'Listopad', 'Grudzień']
		/**
		 * Odmiana rzeczowników dla liczb
		 */
		public function numericalDeclension(nr:uint, one:String, two:String,five:String):String {
			var ret:String=''
			if(nr==1){
				ret=one
			}else if(nr==0){
				ret=five
			}else if(nr>=5 && nr<=21){
				ret=five
			}else{
				var strV:String=String(nr)
				var lastN:Number=Number(strV.substr(strV.length-1))
				if(lastN>=2 && lastN<=4){
					ret=two
				}else {//if(lastN>=5 && lastN <=9
					ret=five
				}
			}
			return ret;
		}
	}
}