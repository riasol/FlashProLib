package flashprolib.flexx {
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	
	import mx.collections.ArrayCollection;
	import mx.controls.List;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IFactory;
	import mx.events.ListEvent;

	public class ListSimpleEditable extends List {
		public var newItemFactory:IFactory
		public function ListSimpleEditable() {
			super();
			doubleClickEnabled=true
			addEventListener(MouseEvent.DOUBLE_CLICK, evDblClick)
			addEventListener(ListEvent.ITEM_EDIT_END, evItemEditEnd)
			addEventListener(KeyboardEvent.KEY_DOWN, evKeyboardEvent)
			var cmi:ContextMenuItem=new ContextMenuItem('dodaj')
			if(contextMenu==null){
				var cm:ContextMenu=new ContextMenu()
				contextMenu=cm
			}
			contextMenu.customItems.push(cmi)
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,function(e:ContextMenuEvent):void{
				addNewItem()
			})
			//addEventListener(ListEvent.ITEM_DOUBLE_CLICK,evDblItemClick)
		}
		private function evEnter(e:Event):void {

		}
		private function evDblClick(e:MouseEvent):void {
			var item:IListItemRenderer=mouseEventToItemRenderer(e);
			if(item) {
				editable=true
			} else if(!editable){
				addNewItem()
			}
		}
		private function addNewItem():void{
			var newItem:Object
			if(newItemFactory is IFactory){
				newItem=newItemFactory.newInstance()
			}else{
				newItem={label:'new',uid:String(new Date().time+Math.random())}
			}
			if(dataProvider is ArrayCollection) {
					ArrayCollection(dataProvider).addItem(newItem)
				} else if(dataProvider is Array) {
					Array(dataProvider).push(newItem)
				}
		}
		private function evDblItemClick(e:ListEvent):void {
			editable=true
		}
		private function evItemEditEnd(e:ListEvent):void {
			editable=false
		}
		private function evKeyboardEvent(e:KeyboardEvent):void {
			if(e.keyCode == Keyboard.DELETE && e.currentTarget==this) {
				if(selectedIndex > -1) {
					if(dataProvider is ArrayCollection) {
						ArrayCollection(dataProvider).removeItemAt(selectedIndex)
					} else if(dataProvider is Array) {
						Array(dataProvider).splice(selectedIndex,1)
					}
				}
			}
		}
	}
}