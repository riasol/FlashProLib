package flashprolib.flexx
{
	import flash.events.MouseEvent;
	
	import mx.controls.CheckBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.listClasses.BaseListData;

	public class SelectItemEditor extends CheckBox
	{
		public function SelectItemEditor()
		{
			super();
			addEventListener(MouseEvent.CLICK,evClick)
		}
		override protected function set listData(value:BaseListData):void{
			super.listData=value
			
		}
		private function evClick(e:MouseEvent):void{
			//DataGridColumn(listData.owner).editorDataField
		}
	}
}