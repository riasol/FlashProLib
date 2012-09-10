package amu.site.events
{
	import amu.site.assets.INavigationItem;
	
	import cms2.site.vo.PageRequestVO;

	public class NavigationEvent extends TargetableEvent
	{
		public static const EVENT_ITEM_SELECT:String="EVENT_ITEM_SELECT";
		public static const EVENT_ITEM_OVER:String="EVENT_ITEM_OVER";
		public static const EVENT_ITEM_OUT:String="EVENT_ITEM_OUT";
		public static const EVENT_SUBMENU_REQUIRED:String="EVENT_SUBMENU_REQUIRED";
		public static const EVENT_SUBMENU_AVAILABLE:String="EVENT_SUBMENU_AVAILABLE";
		public static const EVENT_MENU_SHOW_REQUIRED:String="EVENT_MENU_SHOW_REQUIRED";
		public static const EVENT_MENU_ACTION_EXPAND_FINISHED:String="EVENT_MENU_ACTION_EXPAND_FINISHED";
		public static const EVENT_CONTENT_VIEW_CLOSED:String="EVENT_CONTENT_VIEW_CLOSED";
		public static const EVENT_TARGET_PATH_CHANGED:String="EVENT_TARGET_PATH_CHANGED";
		public static const EVENT_CONTENT_VIEW_CLOSE_REQUIRED:String="EVENT_CONTENT_VIEW_CLOSE_REQUIRED";
		public static const EVENT_SET_HIDDEN:String="EVENT_SET_HIDDEN";
		/**
		 * Użytkownik nawiguje do nowego ekranu, wyzwalane z dowolengo miejsca , nie tylko z menu
		 */ 
		public static const EVENT_NAVIGATE:String="EVENT_NAVIGATE";
		/**
		 * Wygenerowano nowy cel nawigacji
		 */ 
		public static const EVENT_NEW_NAVIGATION_TARGET:String="EVENT_NEW_NAVIGATION_TARGET";
		public static const EVENT_NEW_HISTORY_ITEM:String="EVENT_NEW_HISTORY_ITEM";
		public var label:String;
		public var id:String;
		public var getParams:Object;
		public var item:INavigationItem;
		public var pageRequest:PageRequestVO;
		public var subitems:Array
		function NavigationEvent(type:String, bubbles : Boolean = false, cancelable : Boolean = false,tg:Object=null){
			super(type,bubbles,cancelable,tg);
		}
	}
}