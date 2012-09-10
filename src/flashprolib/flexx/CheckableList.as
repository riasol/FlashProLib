package flashprolib.flexx
{
	
	import mx.controls.List;

	public class CheckableList extends List
	{
		public function CheckableList()
		{
			super();
			itemRenderer=new CheckItemRenderer()
			selectable=false
		}
		
	}
}