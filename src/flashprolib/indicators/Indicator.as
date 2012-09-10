package flashprolib.indicators {
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import flashprolib.indicators.visualizers.AbstractIndicatorVisualizer;


	public class Indicator extends Sprite {
		private var parentContainer:DisplayObjectContainer;
		private var tmr:Timer;
		private var visualizer:AbstractIndicatorVisualizer;
		private var loadEventDispather:EventDispatcher;
		private var config:IndicatorConfig
		private static var instancesCounter:uint=0;
		private var index:uint;
		function Indicator(parentContainer:DisplayObjectContainer, loadEventDispather:EventDispatcher=null, c:IndicatorConfig=null) {
			instancesCounter++
			index=instancesCounter
			this.parentContainer=parentContainer
			parentContainer.addChild(this)
			if(loadEventDispather is EventDispatcher) {
				this.loadEventDispather=loadEventDispather
				loadEventDispather.addEventListener(Event.COMPLETE, evLoadComplete, false, 0, true)
				loadEventDispather.addEventListener(ProgressEvent.PROGRESS, evLoadProgres, false, 0, true)
				if(loadEventDispather is LoaderInfo){
					try{
					LoaderInfo(loadEventDispather).loader.addEventListener(ProgressEvent.PROGRESS, evLoadProgres, false, 0, true)
					}catch(e:Error){trace('silently skip adding event listener to LoaderInfo')}
				}
			}
			if(c == null) {
				config=IndicatorConfig.getDefaultInstance()
			}else{
				config=c
			}
			visualizer=new config.visualizerClass(config.visualizerConfigClass);
			addChild(visualizer);
			x=config.x
			y=config.y
			tmr=new Timer(50)
			tmr.addEventListener(TimerEvent.TIMER, evTimer)
			tmr.start()
			addEventListener(Event.REMOVED_FROM_STAGE,evRemovedFromStage)
		}
		private function evRemovedFromStage(e:Event):void {
			 instancesCounter--;
		}
		private function evTimer(e:TimerEvent):void {
			if(config.oneInstanceVisible){
				visible=index==instancesCounter
			}
			visualizer.update(loadData)
		}
		private var loadData:LoadVO=new LoadVO()
		private function evLoadComplete(e:Event):void {
			removeMe()
		}
		private function evLoadProgres(e:ProgressEvent):void {
			loadData.bl=e.bytesLoaded
			loadData.bt=e.bytesTotal
		}
		public function removeMe():void {
			try {
				tmr.stop()
			} catch(e:Error) {
//pass as not resolveable topic
			}
			try {
				if(loadEventDispather) {
					loadEventDispather.removeEventListener(Event.COMPLETE, evLoadComplete)
				}
				parentContainer.removeChild(this)
			} catch(e:Error) {
				//as over
			}
		}

	}

}