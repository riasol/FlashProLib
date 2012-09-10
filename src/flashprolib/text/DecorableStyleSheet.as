package flashprolib.text {
	import flash.text.StyleSheet;

	public class DecorableStyleSheet {
		//http://kuler.adobe.com/#themeID/768375
		public var textColor:String='#2d3737'
		public var textHighlightColor:String='#80735f'
		public function decorateAnchors(s:StyleSheet):void {
			s.setStyle('a', {textDecoration:'underline'})
			s.setStyle('a:hover', {color:textHighlightColor,textDecoration:'none'})
		}
	}
}