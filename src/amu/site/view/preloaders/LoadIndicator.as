package amu.site.view.preloaders {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;

	/**
		var li:LoadIndicator=new LoadIndicator(this,loader)
		//li.circleR=
		//[another settings]
		li.start()
		 * @deprecated @see flashprolib.indicators.Indicator
	 */
	public class LoadIndicator extends Sprite {
		/** Promień okręgu
		 * @deprecated
		 * */
		public var r:Number=9;
		/** Promień kuleczki
		 * @deprecated
		 * */
		public var circleR:Number=1.5;
		/** Promień kuleczki
		 * @deprecated
		 * */
		private var pointScale:Number;
		private var maxParts:int
		private var parentContainer:DisplayObjectContainer
		private var tmr:Timer
		private var ptr:int
		private var loadEventDispather:EventDispatcher
		public var fillColor:uint=0xcccccc;
		public var glowColor:uint=0xcccccc;
		function LoadIndicator(parentContainer:DisplayObjectContainer, loadEventDispather:EventDispatcher) {
			this.parentContainer=parentContainer
			this.loadEventDispather=loadEventDispather
			parentContainer.addChild(this)
			loadEventDispather.addEventListener(Event.INIT, evLoadInit, false, 0, true)
		}
		/**
		 * Call after property configuration
		 */
		public function start():void {
			var cRef:LoadIndicatorConfig=LoadIndicatorConfig.getInstance()
			if(cRef.configChanged) {
				circleR=cRef.circleR
				fillColor=cRef.fillColor
				glowColor=cRef.glowColor
				r=cRef.r
				if(!isNaN(cRef.x)) {
					x=cRef.x
				}
				if(!isNaN(cRef.y)) {
					y=cRef.y
				}
			}
			alpha=0
			pointScale=360 * 3 * circleR / (2 * Math.PI * r)
			maxParts=Math.round(360 / pointScale)
			createChildren()
			tmr=new Timer(100)
			tmr.addEventListener(TimerEvent.TIMER, evUpdateVisual)
			tmr.start()
			filters=[new GlowFilter(glowColor, 1, 5, 5, 1, 1)]
			ptr=0;
		}
		private function createChildren():void {
			var step:Number=360 / maxParts
			for(var i:int=0; i < maxParts; i++) {
				var pointIndicator:Sprite=new Sprite()
				addChild(pointIndicator)
				pointIndicator.x=r * Math.cos(step * i * 2 * Math.PI / 360)
				pointIndicator.y=r * Math.sin(step * i * 2 * Math.PI / 360)
				pointIndicator.graphics.lineStyle(1, 0x000000, 0)
				pointIndicator.graphics.beginFill(fillColor)
				pointIndicator.graphics.drawCircle(0, 0, circleR)
				pointIndicator.graphics.endFill()
			}
		}
		private function evUpdateVisual(e:TimerEvent):void {
			if(!visible) {
				return;
			}
			var used:int=10
			alpha=Math.min(alpha + 0.05, 1)
			for(var i:int=0; i < maxParts; i++) {
				var cIdx:int=i - used / 2
				if(cIdx < 0) {
					cIdx=maxParts + cIdx
				}
				if(i > ptr - used / 2 && i < ptr + used / 2) {
					getChildAt(cIdx).alpha=Math.abs(i - ptr) / (used / 2)
				} else {
					getChildAt(cIdx).alpha=1
				}
			}
			ptr++
			if(ptr == maxParts) {
				ptr=0
			}
		}
		private function evLoadInit(e:Event):void {
			removeMe()
		}
		public function evLoadComplete(e:Event):void {
			removeMe()
		}
		public function removeMe():void {
			try {
				tmr.stop()
			} catch(e:Error) {
//pass as not resolveable topic
			}
			try {
				loadEventDispather.removeEventListener(Event.INIT, evLoadInit)
				parentContainer.removeChild(this)
			} catch(e:Error) {
				//as over
			}
		}

	}

}