package flashprolib.util {
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class SlideshowNavigation {
		public var backButtonName:String='back_mc'
		public var forwardButtonName:String='play_mc'
		public var closeButtonName:String='close_mc'
		private var target:MovieClip
		private var assignFlags:Object
		private var storeFrameNumber:int;
		private var stopFrameNumber:int;
		public var firstFrame:String="";
		public var lastFrame:String="";
		private var callback:ISlideshowNavigationCallback
		private var currentFrameName:String=''
		private var visitedFramesNumbers:Vector.<int>
		private var visitedFramesPointer:uint;
		private var debug:Boolean=true
		public function setup(target:MovieClip, callback:ISlideshowNavigationCallback):void {
			this.target=target;
			this.callback=callback
			assignFlags={}
			assignFlags[backButtonName]=assignFlags[forwardButtonName]=assignFlags[closeButtonName]=false
			target.addEventListener(Event.ENTER_FRAME, onEnterFrame)
		}

		private function onEnterFrame(e:Event):void {
			if(!assignFlags[backButtonName] && target.hasOwnProperty(backButtonName) && target[backButtonName] is InteractiveObject) {
				controlBtnsDisplay(false)
				assignFlags[backButtonName]=true;
				with((target[backButtonName] as InteractiveObject)) {
					addEventListener(MouseEvent.CLICK, onBackClick)
					//buttonMode=true
				}
			}
			if(!assignFlags[closeButtonName] && target.hasOwnProperty(closeButtonName) && target[closeButtonName] is InteractiveObject) {
				try {
					with((target[closeButtonName] as InteractiveObject)) {
						addEventListener(MouseEvent.CLICK, onCloseClick)
						//buttonMode=true
					}
					assignFlags[closeButtonName]=true
				} catch(er:Error) {
				}
			}
			if(!assignFlags[forwardButtonName] && target.hasOwnProperty(forwardButtonName) && target[forwardButtonName] is InteractiveObject) {
				try {
					with((target[forwardButtonName] as InteractiveObject)) {
						addEventListener(MouseEvent.CLICK, onForwardClick)
						//buttonMode=true
					}
					controlBtnsDisplay(false)
					assignFlags[forwardButtonName]=true
				} catch(er:Error) {
				}
			}
			if(target.currentFrameLabel != null && target.currentFrameLabel.indexOf('stop') > -1 && stopFrameNumber != target.currentFrame) {
				currentFrameName=target.currentFrameLabel
				stopFrameNumber=target.currentFrame
				target.stop()
				controlBtnsDisplay(true)
				if(visitedFramesNumbers.indexOf(target.currentFrame) == -1) {
					visitedFramesNumbers.push(target.currentFrame)
				}
				visitedFramesPointer=visitedFramesNumbers.indexOf(target.currentFrame)
				fixButtons()
				if(debug)
					trace(target.currentFrame + ' ' + visitedFramesPointer)
			}
		}
		private function fixButtons():void{
			for each(var o:Object in target){
				if(o is SimpleButton && [backButtonName,forwardButtonName,closeButtonName].indexOf((o as SimpleButton).name)==-1){
					(o as SimpleButton).useHandCursor=false
				}
			}
		}
		private function onBackClick(e:MouseEvent):void {
			stopFrameNumber=-1
			target.currentFrame
			controlBtnsDisplay(false)
			if(debug)
				trace(visitedFramesPointer)
			target.gotoAndPlay(visitedFramesPointer>=2?(visitedFramesNumbers[visitedFramesPointer - 2] + 1):1)
		}
		private function onForwardClick(e:MouseEvent):void {
			stopFrameNumber=-1
			storeFrameNumber=target.currentFrame
			if(debug)
				trace(visitedFramesPointer)
			target.play()
			controlBtnsDisplay(false)
		}
		private function onCloseClick(e:MouseEvent):void {
			callback.onSlideshowNavigationCloseClick()
		}
		private function controlBtnsDisplay(showing:Boolean):void {
			var visFlag:Boolean
			visFlag=(target[backButtonName] as DisplayObject).visible;
			(target[backButtonName] as DisplayObject).visible=showing && currentFrameName != firstFrame && !isNaN(storeFrameNumber);
			callback.animateSlideshowNavigationControll(target[backButtonName] as DisplayObject, visFlag)
			visFlag=(target[forwardButtonName] as DisplayObject).visible;
			(target[forwardButtonName] as DisplayObject).visible=showing && currentFrameName != lastFrame;
			callback.animateSlideshowNavigationControll(target[forwardButtonName] as DisplayObject, visFlag);
			visFlag=(target[closeButtonName] as DisplayObject).visible;
			(target[closeButtonName] as DisplayObject).visible=showing;
			callback.animateSlideshowNavigationControll(target[closeButtonName] as DisplayObject, visFlag);
		}
		public function play():void {
			visitedFramesNumbers=new Vector.<int>()
			target.gotoAndPlay(1)
		}
		public function stop():void {
			controlBtnsDisplay(false)
			target.gotoAndStop(1)
		}
	}
}