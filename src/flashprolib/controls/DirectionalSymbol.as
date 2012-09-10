package flashprolib.controls {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flashprolib.util.MathExtensions;

	public class DirectionalSymbol extends Sprite {
		private var clickArea:Sprite;
		private var rotateArea:Sprite;
		private var editIndicator:Sprite;
		private var rBase:Number=10
		public static const EVENT_DS_SELECTION_CHANGE:String='EVENT_DS_SELECTION_CHANGE'
		private var rotFlag:Boolean;
		private var startRot:Number;
		private var content:Sprite;
		private var hitSymbol:Sprite;
		public function DirectionalSymbol() {
			super();
			content=new Sprite()
			addChild(content)
			content.graphics.lineStyle(1, 0x000000)
			content.graphics.lineTo(0, -rBase * 2)
			content.graphics.endFill()


			rotateArea=new Sprite()
			content.addChild(rotateArea)
			rotateArea.graphics.lineStyle(5, 0x000000, 0.5)
			rotateArea.graphics.drawCircle(0, 0, rBase * 1.5)
			rotateArea.graphics.endFill()
			rotateArea.visible=false
			rotateArea.addEventListener(MouseEvent.MOUSE_DOWN, evRotMouseDown)
			rotateArea.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void {
					rotFlag=false
				})

			rotateArea.addEventListener(Event.ENTER_FRAME, evRotEF);
			editIndicator=new Sprite()
			content.addChild(editIndicator)
			editIndicator.graphics.beginFill(0xff0000, 0.5)
			editIndicator.graphics.lineStyle(0)
			editIndicator.graphics.drawCircle(0, 0, rBase + 1)
			editIndicator.graphics.endFill()
			editIndicator.visible=false

			clickArea=new Sprite()
			content.addChild(clickArea)
			clickArea.graphics.beginFill(0x000000, 0.5)
			clickArea.graphics.lineStyle(0)
			clickArea.graphics.drawCircle(0, 0, rBase)
			clickArea.graphics.endFill()
			clickArea.doubleClickEnabled=true
			clickArea.addEventListener(MouseEvent.DOUBLE_CLICK, function(e:MouseEvent):void {
					selected=!selected
					dispatchEvent(new Event(EVENT_DS_SELECTION_CHANGE))
				})
			clickArea.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
					if(selected) {
						startDrag()
					}
				})
			clickArea.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void {
					stopDrag()
				})
			hitSymbol=new Sprite()
			addChild(hitSymbol)
			hitSymbol.mouseEnabled=false
			hitSymbol.graphics.beginFill(0x000000, 0)
			hitSymbol.graphics.drawCircle(0, 0, rBase * 2)
		}
		private var startORot:Number
		private function evRotMouseDown(e:MouseEvent):void {
			startORot=content.rotation
			startRot=MathExtensions.rad2deg(Math.atan2(mouseY, mouseX))
			rotFlag=true
		}
		private function evRotEF(e:Event):void {
			if(rotFlag) {
				content.rotation=startORot + MathExtensions.rad2deg(Math.atan2(mouseY, mouseX)) - startRot
				if(!hitSymbol.hitTestPoint(stage.mouseX, stage.mouseY)) {
					rotFlag=false
				}
			}
		}
		private var _selected:Boolean
		public function set selected(b:Boolean):void {
			_selected=b
			rotateArea.visible=editIndicator.visible=_selected
		}
		public function get selected():Boolean {
			return _selected
		}
		public function set vo(v:DirectionalVO):void {
			_vo=v
			x=_vo.x
			y=_vo.y
			content.rotation=_vo.rotation
		}
		private var _vo:DirectionalVO
		public function get vo():DirectionalVO {
			if(_vo == null){
				_vo=new DirectionalVO()
			}
			_vo.x=x
			_vo.y=y
			_vo.rotation=content.rotation
			return _vo;
		}
	}
}