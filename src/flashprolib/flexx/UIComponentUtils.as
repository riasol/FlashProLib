package flashprolib.flexx{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	
public class UIComponentUtils
{
	public static function set100Percent(comp:UIComponent,widthAlways:Boolean=true,heightAlways:Boolean=true):void{
		function applyOn(comp:UIComponent,widthAlways:Boolean=true,heightAlways:Boolean=true):void{
			if(isNaN(comp.percentWidth) && isNaN(comp.percentHeight)){
				if(widthAlways){
					comp.percentWidth=100
				}
				if(heightAlways){
					comp.percentHeight=100
				}
				for(var i:int=0;i<comp.numChildren;i++){
					var sub:DisplayObject=comp.getChildAt(i) 
					if(sub is UIComponent){
						applyOn(sub as UIComponent,widthAlways,heightAlways)
					}
				}
			}
		}
		applyOn(comp,widthAlways,heightAlways)
		}
	/**
	 * Make slider change targetComponent property
	 */ 
	public static function assingSliderControl(slider:UIComponent,targetComponent:Object):void{
		if(!targetComponent.hasOwnProperty(slider.id)){
			throw new Error('target component '+targetComponent+' must have '+slider.id+' property' );
		}
		slider['value']=targetComponent[slider.id]
		slider.addEventListener(Event.CHANGE,function(e:Event):void{
			targetComponent[e.currentTarget.id]=e.currentTarget.value
		})
	}
}
}