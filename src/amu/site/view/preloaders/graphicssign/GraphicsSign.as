package amu.site.view.preloaders.graphicssign {
	import amu.site.base.SpeedDetector;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import mx.preloaders.IPreloaderDisplay;
	public class GraphicsSign extends Sprite implements IPreloaderDisplay {
		private var graphicsLoader:Loader;
		private var barObject:Sprite;
		private var loaderGraphics:Sprite;
		private var speedDetector:SpeedDetector;
		public static var instance:GraphicsSign
		public static var loadCnt:int=0;
		private var movieProgress:MovieProgress
		private static var wasShowed:Boolean
		public function GraphicsSign() {
			super();
			instance=this
			addEventListener(Event.ENTER_FRAME, evEnterFrame)
			visible=false
		}
		public function initialize():void {
			if(loaderInfo && loaderInfo.parameters.hasOwnProperty('additionalBytes')) {
				Config.additionalBytes=Number(loaderInfo.parameters.additionalBytes)
			}
			loaderGraphics=new Sprite()
			addChild(loaderGraphics)
			if(Config.barClass != null) {
				barObject=new Config.barClass() as Sprite
				loaderGraphics.addChild(barObject)
				for(var p:String in Config.barConfig) {
					IBar(barObject)[p]=Config.barConfig[p]
				}
			}
			//var co:Config=new Config()//dest in debuging
			if(Config.graphicsClass != null) {
				var c:Sprite=new Config.graphicsClass() as Sprite
				loaderGraphics.addChild(c)
			} else if(Config.bitmapClass != null) {
				var b:Bitmap=new Config.bitmapClass() as Bitmap
				loaderGraphics.addChild(b)
			} else if(Config.graphicsPath != null && Config.graphicsPath != "") {
				graphicsLoader=new Loader()
				graphicsLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
						loaderGraphics.addChild(graphicsLoader)
						if(e.currentTarget.hasOwnProperty('content') && e.currentTarget.content.hasOwnProperty('movieProgress')) {
							movieProgress=e.currentTarget.content.movieProgress as MovieProgress
						}
					})
				graphicsLoader.load(new URLRequest(Config.graphicsPath), new LoaderContext(false, ApplicationDomain.currentDomain))
			}
		}
		private function evEnterFrame(e:Event):void {
			positionMe() 
		}
		private var positioned:Boolean;
		private var lastSize:Number;
		private function positionMe():void {
			if(root != null) {//trace('loaderGraphics.width '+loaderGraphics.width)
				//Fix: Bład czytania rozmiaru
				visible=lastSize > 0 && lastSize==(loaderGraphics.width*loaderGraphics.height)
				lastSize=loaderGraphics.width*loaderGraphics.height
				positioned=true
				loaderGraphics.x=root.width / 2 - loaderGraphics.width / 2
				loaderGraphics.y=root.height / 2 - loaderGraphics.height / 2
				if(Config.barClass != null) {
					barObject.x=IBar(barObject).position.x
					barObject.y=IBar(barObject).position.y
				}
			}
		}
		public function set preloader(obj:Sprite):void {
			obj.addEventListener('initComplete', evInitComplete)
			obj.addEventListener(ProgressEvent.PROGRESS, evProgress)
			speedDetector=new SpeedDetector(obj)
			alpha=0
		}
		public function set loaderInfo(obj:LoaderInfo):void {
			obj.addEventListener(Event.COMPLETE, evComplete)
			obj.addEventListener(ProgressEvent.PROGRESS, evProgress)
			if(wasShowed) {
				visible=true
				positionMe()
			} else {
				speedDetector=new SpeedDetector(obj)
			}
		}
		private function evInitComplete(e:Event):void {
			GraphicsSign.loadCnt++
			dispatchEvent(new Event(Event.COMPLETE))
		}
		private static var blRegister:Array=[0, 0]
		public function evProgress(e:ProgressEvent):void {
			var bl:Number=e.bytesLoaded
			var bt:Number=e.bytesTotal
			blRegister[GraphicsSign.loadCnt]=bt
			if(Config.additionalBytes > 0) {
				if(GraphicsSign.loadCnt == 0) {
					bt+=Config.additionalBytes
				} else if(GraphicsSign.loadCnt == 1) { //ładowanie drugiego
					bl+=blRegister[GraphicsSign.loadCnt - 1]
					bt+=blRegister[GraphicsSign.loadCnt - 1]
				}
			}
			//trace(bl +' - '+ bt)
			var prc:Number=bl / bt
			if(barObject != null) {
				IBar(barObject).percent=prc
			}
			if(movieProgress is MovieProgress) {
				movieProgress.setProgressData(prc, GraphicsSign.loadCnt)
			}
			if(!visible && speedDetector != null && speedDetector.showRule && positioned) {
				visible=true
				wasShowed=true
			}
			if(visible && alpha<1){
				alpha=Math.min(alpha+0.05,1)
			}
		}
		public function evComplete(e:Event):void {
			if(parent != null) {
				parent.removeChild(this)
			}

		}
		public function get stageHeight():Number {

			return root["measuredHeight"];
		}

		public function set stageHeight(value:Number):void {

		}

		public function get stageWidth():Number {

			return root["measuredWidth"];
		}

		public function set stageWidth(value:Number):void {

		}
		public function get backgroundAlpha():Number {

			return 0;
		}

		public function set backgroundAlpha(value:Number):void {

		}

		public function get backgroundColor():uint {

			return 0;
		}

		public function set backgroundColor(value:uint):void {

		}

		public function get backgroundImage():Object {

			return null;
		}

		public function set backgroundImage(value:Object):void {

		}

		public function get backgroundSize():String {

			return null;
		}

		public function set backgroundSize(value:String):void {

		}

	}
}