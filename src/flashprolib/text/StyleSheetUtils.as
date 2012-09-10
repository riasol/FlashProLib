package flashprolib.text {
	import flash.text.StyleSheet;
	import flash.text.TextField;


	public class StyleSheetUtils {
		public static function applyStyle(text:String,field:TextField):void{
			var style:StyleSheet=new StyleSheet();
				style.parseCSS(text);
				field.styleSheet=style;
		}
	}
}