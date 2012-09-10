package flashprolib.flexx
{
	import flash.events.MouseEvent;
	
	import mx.controls.CheckBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	import mx.core.IFactory;
/**
 *Using:
 <mx:DataGridColumn 
	dataField="boolF" 
	editable="true"
	itemRenderer="flashprolib.flexx.CheckBoxItemEditor" 
			/>
 */ 
	public class CheckBoxItemEditor extends CheckBox implements IFactory
	{
		private var dataField:String
		public function CheckBoxItemEditor()
		{
			super();
			addEventListener(MouseEvent.CLICK,evClick)
		}
		override public function set listData(list:BaseListData):void{
			super.listData=list
			if(list is DataGridListData){
				dataField=DataGridListData(list).dataField
			}
		}
		private function evClick(e:MouseEvent):void{
			if(dataField!=null){
				data[dataField]=selected
			}
		}
		public function newInstance():*{
			return new CheckBoxItemEditor()
		}
	}
}