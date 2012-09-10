package amu.site.view
{
	import cms2.site.vo.PageRequestVO;
	

	public interface IPageRequestConsumer
	{
		function set pageRequest(pr:PageRequestVO):void;
	 	function get pageRequest():PageRequestVO;
	}
}