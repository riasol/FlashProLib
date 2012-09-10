package flashprolib.formatters {
	public class DateFormat {
		public static var nazwyDni:Array=['Nd', 'Pn', 'Wt', 'Śr', 'Cz', 'Pt', 'Sb'];
		public static var nazwyMiesiecy:Array=['Styczeń', 'Luty', 'Marzec', 'Kwiecieć', 'Maj', 'Czerwiec', 'Lipiec', 'Sierpień', 'Wrzesień', 'Październik', 'Listopad', 'Grudzień'];
		public static function dateForUnixStamp(stamp:uint, withTime:Boolean=false):String {
			var date:Date=new Date(stamp * 1000)
			var s:String=date.date + "-" + (date.getMonth() + 1) + "-" + date.getFullYear()
			if(withTime) {
				s+=" " + date.hours + ":" + date.minutes + ":" + date.seconds
			}
			return s
		}
		public static function dateInstanceForUnixStamp(stamp:uint):Date {
			return new Date(stamp * 1000)
		}
		public static function unixStampForDate(date:Date, koniecDnia:Boolean=false, poczatekDnia:Boolean=false):uint {
			var d:Date
			if(date.getFullYear() == 1970) { //uproszczenie - proktycznie nie stosujemy takich wczesnych więc zrównujemy z unixstamp=0
				date=new Date()
				date.setTime(0)
			} else {
				if(koniecDnia) {
					d=new Date(date)
					d.setHours(23)
					d.setMinutes(59)
					d.seconds=59
					return d.getTime() / 1000
				} else if(poczatekDnia) {
					d=new Date(date)
					d.setHours(0)
					d.setMinutes(0)
					d.seconds=0
					return d.getTime() / 1000
				}
			}
			
			return date.getTime() / 1000
		}
		/**
		 * @argument inStr in for 9:15
		 */
		public static function hourString2Number(inStr:String):Number {
			var parts:Array=inStr.split(':')
			var nr:Number=parseInt(parts[0])
			nr+=(parseInt(parts[1]) / 60)
			return nr
		}
		/**
		 * Convert seconds to h:m:ss string
		 */
		public static function seconds2hms(seconds:Number):String {
			var h:Number=Math.floor(seconds / 3600)
			var m:Number=Math.floor((seconds - h * 3600) / 60)
			var s:Number=Math.ceil(seconds - h * 3600 - m * 60)
			var ret:String=''
			if(h > 0) {
				ret+=h + ':'
			}
			if(m > 0) {
				ret+=m + ':'
			}
			var ss:String=String(s)
			if(ss.length==1){
				ss='0'+ss
			}
			ret+=ss
			return ret;
		}
	}
}