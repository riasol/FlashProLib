package amu.site.assets{
	public interface INavigationItem{
	function set label(s:String):void
	function get label():String
	function set id(s:String):void
	function get id():String
	function set level(l:uint):void
	function get level():uint
	function set config(a:Array):void
	function get config():Array
	}
}