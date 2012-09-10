package amu.site.base {
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	import mx.core.Application;


	public class ContextMenuManager {
		private static var instance:ContextMenuManager
		public static function getInstance():ContextMenuManager {
			if(instance == null) {
				instance=new ContextMenuManager()
			}
			return instance;
		}
		public function contributeDefault(target:*=null):void {
			if(target == null) {
				target=Application.application
			}
			var cm:ContextMenu=new ContextMenu()
			target.contextMenu=cm
			cm.hideBuiltInItems();
			var item:ContextMenuItem
			item=new ContextMenuItem('Design by AMU...');
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(e:ContextMenuEvent):void {
					navigateToURL(new URLRequest('http://www.amu.pl'), '_blank')
				});
			cm.customItems.push(item)
			item=new ContextMenuItem('Check player version...');
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(e:ContextMenuEvent):void {
					navigateToURL(new URLRequest('/modules/PluginEmbeder/problem.php'), '_blank')
				});
			cm.customItems.push(item)
		}

	}
}