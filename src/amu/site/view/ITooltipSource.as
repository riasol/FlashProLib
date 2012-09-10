package amu.site.view{
	import mx.core.IToolTip;
	
	
	
	public interface ITooltipSource{
	 function set tooltipText(t:String):void;
	 function get tooltipText():String;
	 function set tooltipInstance(tt:IToolTip):void;
	 function get tooltipInstance():IToolTip;
	}
}