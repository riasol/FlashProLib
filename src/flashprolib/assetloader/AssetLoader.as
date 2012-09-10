package flashprolib.assetloader {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flashprolib.util.IoUtils;
/**
 * ładowanie wg kolejek
 */ 
	public class AssetLoader extends EventDispatcher {
		private const NETWORK_BUSY:String='NETWORK_BUSY';
		private const NETWORK_FREE:String='NETWORK_FREE';
		private var networkState:String=NETWORK_FREE
		private var _queue:Array
		private var loader:URLLoader;
		private var curPath:String;
		private static var instance:AssetLoader;
		private var isLoading:Boolean=false
		public var noCache:Boolean=false
		public static function getInstance():AssetLoader {
			if(instance == null) {
				instance=new AssetLoader()
			}
			return instance;
		}
		public function AssetLoader(target:IEventDispatcher=null) {
			super(target);
			loader=new URLLoader()
			loader.addEventListener(Event.COMPLETE, evComplete)
				IoUtils.ioErrorsGuard(loader)
			cleanup()
		}
		public function cleanup():void {
			isLoading=false
			try {
				loader.close()
			} catch(e:Error) { //silent
			}
			_queue=new Array()
		}
		private function evComplete(e:Event):void {
			findItem().loaded=true
				var aEvent:AssetLoaderEvent=new AssetLoaderEvent(AssetLoaderEvent.EVENT_LOADED_ASSET)
				aEvent.data=findItem().path
					dispatchEvent(aEvent)
				isLoading=false
			sortQueue()
			checkNetwork()
		}
		private function findItem():LoadItem {
			for each(var i:LoadItem in _queue) {
				if(i.path == curPath) {
					return i
				}
			}
			return null
		}
		public function signStart(e:EventDispatcher=null):void {
			networkState=NETWORK_BUSY
			if(e is EventDispatcher){
				e.addEventListener(Event.COMPLETE,signFinish,false,0,true)
			}
		}
		public function signFinish(e:*=null):void {
			networkState=NETWORK_FREE
			checkNetwork()
		}
		/**
		 * @param items Array of LoadItem
		 */
		public function addItems(items:Array):void {
			var toAdd:Array=[]
			for each(var i:LoadItem in items) {
				var found:Boolean=false
				for each(var qi:LoadItem in _queue) {
					if(qi.path == i.path) {
						found=true
						break;
					}
				}
				if(!found) {
					toAdd.push(i)
				}
			}
			_queue=_queue.concat(toAdd)
			sortQueue()
			checkNetwork()
		}
		public function get queue():Array {
			return _queue;
		}
		public function addItem(path:String, priority:uint=0):void {
			addItems([new LoadItem(path)])
		}
		public function sortQueue():void {
			_queue=_queue.sortOn(['loaded', 'priority', 'time'], [null, Array.DESCENDING | Array.NUMERIC, Array.DESCENDING | Array.NUMERIC]);
		}
		private function checkNetwork():void {
			if(networkState == NETWORK_FREE
			&& !_frozen
			&& _queue.length > 0
			&& !LoadItem(_queue[0]).loaded
			&& !isLoading) {
				isLoading=true
				curPath=LoadItem(_queue[0]).path
				loader.load(new URLRequest(curPath + (noCache ? '?' + Math.random() * 1000 : '')))
			}
		}
		private var _frozen:Boolean=false;
		public function set frozen(b:Boolean):void {
			_frozen=b
		}
		public function get frozen():Boolean {
			return _frozen
		}
	}
}