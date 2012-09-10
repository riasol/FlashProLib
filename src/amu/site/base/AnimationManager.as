package amu.site.base{
	import amu.site.events.AnimationEvent;
	
	
	public class AnimationManager{
		private var animations:Object
		private static var instance:AnimationManager
		public static function getInstance():AnimationManager{
			if(instance==null){
				instance=new AnimationManager()
				instance.animations=new Object();
			}
			return instance;
		}
		
		public function getAnimation(key:String):XML{
			return new XML(animations[key])
		}
		public function prefetch(ids:Array):void{
			var ids2:Array=new Array()
			for each(var k:String in ids){
				if(!animations.hasOwnProperty(k)){
					ids2.push(k)
				}
			}
			var ev:AnimationEvent=new AnimationEvent(AnimationEvent.EVENT_LOAD_ANIMATIONS);
			ev.keys=ids2
			ev.dispatch()
		}
		public function reloadAnimations():void{
			var ev:AnimationEvent=new AnimationEvent(AnimationEvent.EVENT_LOAD_ANIMATIONS);
			ev.keys=new Array()
			for (var k:String in animations){
				ev.keys.push(k)
			}
			ev.dispatch()
		}
		public function push(id:String,v:String):void{
			animations[id]=v;
			animations.setPropertyIsEnumerable(id,true);
		}
	}
}