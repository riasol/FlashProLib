package amu.site.view{
	import cms2.site.vo.PageRequestVO;
	
	import flash.display.Sprite;
	
	public interface IContentController{
	 function set asset(a:Sprite):void;
	 function get asset():Sprite;
	 function set pageRequest(pr:PageRequestVO):void;
	 function get pageRequest():PageRequestVO;
	}
}