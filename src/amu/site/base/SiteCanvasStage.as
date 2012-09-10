package amu.site.base
{
	import flash.display.DisplayObject;
	
	import mx.containers.Canvas;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	use namespace mx_internal;

	public class SiteCanvasStage extends Canvas
	{
		public function SiteCanvasStage()
		{
			super();
		}
		override protected function createChildren():void
		{
			super.createChildren();
		}
		public function addFlashChild(obj:DisplayObject):void{
			 addChild(obj)//TODO
		}
		public function removeFlashChild(obj:DisplayObject):void{
			removeChild(obj)//TODO
		}
		
		override mx_internal function addingChild(child:DisplayObject):void
    {
        // Throw an RTE if child is not an IUIComponent.
       // var uiChild:IUIComponent = IUIComponent(child);

        // Set the child's virtual parent, nestLevel, document, etc.
        super.addingChild(child);
        
        invalidateSize();
        invalidateDisplayList();

        

        
    }

	}
}