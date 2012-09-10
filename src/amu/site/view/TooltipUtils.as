package amu.site.view{
	import flash.display.Stage;
	
	import mx.core.Application;
	import mx.core.IToolTip;
	import mx.managers.ToolTipManager;
	
	
	
	
	public class TooltipUtils{
	 public static function createToolTip(iface:ITooltipSource,x:Number=-1212.12,y:Number=-1212.12):void{
	 	if(x==-1212.12){
	 		x=Application.application.stage.mouseX
	 	}
	 	if(y==-1212.12){
	 		y=Application.application.stage.mouseY
	 	}
	 	iface.tooltipInstance=ToolTipManager.createToolTip(iface.tooltipText,x,y)
	 }
	 public static function destroyToolTip(iface:ITooltipSource):void{
	 	ToolTipManager.destroyToolTip(iface.tooltipInstance)
	 }
	}
}