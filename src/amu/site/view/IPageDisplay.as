package amu.site.view{
	import cms2.site.vo.PageRequestVO;
	
	
	public interface IPageDisplay{
	 function set pageRequest(pr:PageRequestVO):void;
	 function get pageRequest():PageRequestVO;
	}
}