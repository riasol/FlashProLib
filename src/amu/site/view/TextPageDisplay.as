package amu.site.view {
	import amu.site.formatters.TextFormatter;
	
	import cms2.site.vo.PageRequestVO;
	
	import flash.text.TextField;


	public class TextPageDisplay extends AbstractPageDisplay {
		private var tf:TextField
		override protected function createMyChildren():void {
			if(tf == null) {
				tf=new TextField()
				addChild(tf)
				tf.width=500
				tf.height=500
			}
		}
		override public function set pageRequest(pr:PageRequestVO):void {
			createMyChildren()
			tf.htmlText=TextFormatter.pageXMLToHTML(pr.content.content as String,false)
		}
	}
}