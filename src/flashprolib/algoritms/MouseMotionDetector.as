package flashprolib.algoritms{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
public class MouseMotionDetector extends Sprite
{
	private var refDispObj:DisplayObject;
	/**
	 * Ile sekund ma okno pomiaru
	 */ 
	public var rampTimeMs:int=5000;
	/**
	 * Ile px w oknie czasowym może przejechać
	 */ 
	public var minSpeed:int=0;
	public static var EVENT_MOUSE_STOPED:String="EVENT_MOUSE_STOPED";
	private var points:Array
	function MouseMotionDetector(d:DisplayObject){
		refDispObj=d
		
	}
	public function start():void{
		points=[]
		addEventListener(Event.ENTER_FRAME,function(e:Event):void{
			points.push([refDispObj.mouseX,refDispObj.mouseY])
		})
		var tmr:Timer=new Timer(rampTimeMs)
		tmr.addEventListener(TimerEvent.TIMER,check)
		tmr.start()
	}
	private function check(e:TimerEvent):void{
			//TODO uzyć jakieś średniej
			var p0:Array=points[0]
			var p1:Array=points.pop()
			if(p0[0]==p1[0] && p0[1]==p1[1]){
				dispatchEvent(new Event(EVENT_MOUSE_STOPED))
			}
			points=[]
		}
	}
}