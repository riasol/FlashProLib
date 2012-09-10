package amu.site.view {
	import amu.site.exceptions.CodeQualityException;
	import amu.site.formatters.TextFormatter;
	
	import cms2.site.vo.PageRequestVO;
	
	
	import mx.core.UIComponent;


	public class AbstractPageDisplay extends UIComponent implements IPageDisplay {

		protected function createMyChildren():void {
			throw new CodeQualityException(CodeQualityException.NOT_OVERRIDEN)
		}
		public function set pageRequest(pr:PageRequestVO):void {
			createMyChildren()
		}
		public function get pageRequest():PageRequestVO {
			return null;
		}
	}
}