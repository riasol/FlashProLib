package flashprolib.fix {
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;

	public class WModeScroll extends Sprite {
		function WModeScroll() {
			if(ExternalInterface.available) {
				ExternalInterface.marshallExceptions=true
				var s:String='document.insertScript=function(){'
					+ 'if(!document.attachEvent){'
					+ 'wModeScrollFix=function(ev){'
					+ ' var swf=document.getElementById("' + ExternalInterface.objectID + '");'
					+ ' if(swf){'
					+ '  var o={};'
					+ '  o.delta=ev.detail;'
					+ '  o.ctrlKey=ev.ctrlKey;'
					+ '  o.altKey=ev.altKey;'
					+ '  o.shiftKey=ev.shiftKey;'
					+ '  swf.handleWheel(o);'
					+ ' }'
					+ '};'
					+ 'window.addEventListener("DOMMouseScroll",wModeScrollFix,false);'
					+ '}'
					+ '}';
				ExternalInterface.call(s)
				ExternalInterface.addCallback("handleWheel", handleWheel);
			}
		}
		public function handleWheel(p:Object):void {
			var mouseObject:InteractiveObject
			var under:Array=stage.getObjectsUnderPoint(new Point(stage.mouseX, stage.mouseY))
			for(var i:int=under.length - 1; i >= 0; i--) {
				if(under[i] is InteractiveObject) {
					mouseObject=under[i] as InteractiveObject
					break;
				} else if(under[i] is Shape && Shape(under[i]).parent) {
					mouseObject=Shape(under[i]).parent
					break;
				}
			}
			var ev:MouseEvent=new MouseEvent(MouseEvent.MOUSE_WHEEL
				, true, false, stage.mouseX, stage.mouseY
				, mouseObject, p.ctrlKey, p.altKey, p.shiftKey
				, false, -p.delta)

			mouseObject.dispatchEvent(ev)
		}
	}
}