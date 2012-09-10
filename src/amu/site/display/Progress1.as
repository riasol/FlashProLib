package amu.site.display{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	   	private var pr:Progress1
	    pr=new Progress1()
		addChild(pr)
		pr.x=300
		pr.y=200
		pr.start(loader.contentLoaderInfo)
	 */ 
	public class Progress1 extends Sprite{
		private var tf:TextField;
		public var maxWidth:Number=200;
		private var tfm:TextFormat
		private var unloadError:Boolean=false;
		private var li:LoaderInfo
		public var generalColor:Number=0xffffff
		public function start(loaderInfo:LoaderInfo):void{
			li=loaderInfo
			tf=new TextField()
			addChild(tf)
			//tf.x=-tf.width/2
			tfm=new TextFormat()
			tfm.color=generalColor
			tf.selectable=false;
			loaderInfo.addEventListener(ProgressEvent.PROGRESS,evProgress,false,0,true)
			loaderInfo.addEventListener(Event.COMPLETE,evComplete,false,0,true)
			loaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,evHTTPStatus,false,0,true)
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,evIOError,false,0,true)
			filters=[new GlowFilter(generalColor,0.6,2,2)]
		}
		private function evHTTPStatus(e:HTTPStatusEvent):void{
			removeAction()
		}
		private function evIOError(e:IOErrorEvent):void{
			removeAction()
		}
		private function evProgress(e:ProgressEvent):void{
			var rel:Number=e.bytesLoaded/e.bytesTotal
			tf.text=Math.round(rel*100)+"%"
			tf.setTextFormat(tfm)
			graphics.clear();
			graphics.lineStyle(2,generalColor)
			graphics.beginFill(generalColor)
			graphics.moveTo(-rel*maxWidth/2,-5)
			graphics.lineTo(rel*maxWidth/2,-5)
			graphics.endFill()
		}
		private function evComplete(e:Event):void{
			removeAction()
		}
		private function removeAction():void{
			try{
				li.removeEventListener(ProgressEvent.PROGRESS,evProgress)
				li.removeEventListener(Event.COMPLETE,evComplete)
				li.removeEventListener(HTTPStatusEvent.HTTP_STATUS,evHTTPStatus)
				li.removeEventListener(IOErrorEvent.IO_ERROR,evIOError)
				parent.removeChild(this)	
			}catch(e:Error){
				unloadError=true
				//trace("Progress1 "+e.message)
			}
		}
		public function removeProgress():void{
			removeAction()
		}
	}
}