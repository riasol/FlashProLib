package flashprolib.flexx
{
	
	import flash.events.MouseEvent;
	
	import mx.controls.CheckBox;
	import mx.controls.List;
	import mx.core.IFactory;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;

	public class CheckItemRenderer extends CheckBox implements IFactory
	{
		public function CheckItemRenderer()
		{
			super();
			selectedField='selected'
			addEventListener(MouseEvent.CLICK,evClick)
		}
		private function evClick(e:MouseEvent):void{
				data.selected=selected
				listData.owner.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,false,CollectionEventKind.UPDATE,-1,-1,List(listData.owner).dataProvider.source as Array))
		}
		public function newInstance():*{
			return new CheckItemRenderer()
		}
	}
}