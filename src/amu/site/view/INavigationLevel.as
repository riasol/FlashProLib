package amu.site.view{
	public interface INavigationLevel{
		 function set navigation(n:INavigation):void;
		 function get navigation():INavigation;
		 /**
		 * Levels numbered from 0
		 */
		 function set level(l:uint):void;
		 function get level():uint;
	}

}
