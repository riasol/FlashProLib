package amu.site.view {

	public interface INavigationItem {
		function set staticActivity(b:Boolean):void
		function get staticActivity():Boolean
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