package flashprolib.text {


	public class HtmlTemplates {
		/**
		 * Clickable link with flash event
		 * using:
		 * textField.htmlText=HtmlTemplates.aWithEvent()
		 * field.addEventListener(TextEvent.LINK,onLink)
		 * var data:Array=TextEventUtils.linkService(e)
		 *
		 */
		public static function aWithEvent(label:String,event:String,eventData:String=""):String {
			var ret:String="<a href=\"event:"+event+","+eventData+"\">"+label+"</a>"
			return ret
		}
	}
}