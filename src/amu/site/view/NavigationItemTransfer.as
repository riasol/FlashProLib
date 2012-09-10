package amu.site.view
{
	public class NavigationItemTransfer implements INavigationItem
	{
		public function NavigationItemTransfer()
		{
		}

		public function set staticActivity(b:Boolean):void
		{
		}
		
		public function get staticActivity():Boolean
		{
			return false;
		}
		private var _label:String
		public function set label(s:String):void
		{
			_label=s
		}
		
		public function get label():String
		{
			return _label;
		}
		private var _id:String
		public function set id(s:String):void
		{
			_id=s
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set level(l:uint):void
		{
		}
		
		public function get level():uint
		{
			return 0;
		}
		
		public function set config(a:Array):void
		{
		}
		
		public function get config():Array
		{
			return null;
		}
		
	}
}