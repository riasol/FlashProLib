package amu.site.base
{
	import flash.display.LoaderInfo;
	import flash.events.ProgressEvent;
	import flash.utils.getTimer;
	

	public class SpeedDetector
	{
		/**
		 * minimalny czas poniżej którego nie warto pokazać progresji [msec]
		 */ 
		private var toFinishLimit:int=2000
		/**
		 * Maksymalny czas jaki czeka się na otrzymanie wielkości całkowitej ładowanej zawartości
		 */ 
		private var toTotalDetectLimit:int=1000
		private var timeOfStart:int
		private var totalSize:Number;
		private var loadedSize:Number;
		public function SpeedDetector(loaderInfo:*)
		{
			 timeOfStart=getTimer()
			 loaderInfo.addEventListener(ProgressEvent.PROGRESS,evProgress)
		}
		private function evProgress(e:ProgressEvent):void{
			if(e.bytesTotal>1){// 1 załatwia nieokreśloność
				totalSize=e.bytesTotal
			}
			if(e.bytesLoaded>1){
				loadedSize=e.bytesLoaded
			}
		}
		/**
		 * Przypuszczalny czas do ukończenia [msec] 
		 */ 
		public function get estimatedToFinish():int{
			var ret:int=-1
			if(totalSize is Number && loadedSize is Number){
				ret=totalSize/speed
			}
			return ret
		}
		/**
		 * bytes/msec
		 */ 
		public function get speed():Number{
			var ret:int=0
			if(loadedSize is Number){
				ret=loadedSize/(getTimer()-timeOfStart)
			}
			return ret
		}
		private var _sizeDetectTimeOver:Boolean=false
		public function get sizeDetectTimeOver():Boolean{
			if(totalSize is Number && (getTimer()-timeOfStart)>toTotalDetectLimit){
				_sizeDetectTimeOver=true
			}
			return _sizeDetectTimeOver
		}
		private var _signShowed:Boolean=false
		/**
		 * Czy pokazać sign
		 */ 
		public function get showRule():Boolean{
			var ret:Boolean=false
			ret=ret || sizeDetectTimeOver
			ret=ret || !sizeDetectTimeOver
			if(estimatedToFinish!=-1){
				ret=ret && estimatedToFinish<toFinishLimit
			}
			ret=ret && !_signShowed
			if(ret){
				_signShowed=ret
			}
			return ret
		}
		
	}
}