package flashprolib.collector {
	import flash.display.InteractiveObject;

	import flashprolib.util.ArrayExtensions;
	/**
	 * Using: Collector.getInstance().simpleConfig(this.stage)
	 * Collector.getInstance().save(0,data)
	 * print: Ctrl+Shift+(0-9)
	 */
	public class Collector {
		public function Collector() {
		}
		private var collection:Array 
		private static var instance:Collector
		public static function getInstance():Collector {
			if(instance == null) {
				instance=new Collector()
				instance.collection=new Array(10);
				ArrayExtensions.fill(instance.collection, function():Array {return []},10)
			}
			return instance
		}
		public function save(index:uint, data:*):void {
			collection[index].push(data)
		}
		private var output:ICollectionOutput;
		public function print(index:uint):void {
			output.print(collection[index])
		}
		public function simpleConfig(ui:InteractiveObject):void {
			var k:CollectorKeyListener=new CollectorKeyListener(ui)
			k.collector=this
			output=new TraceOutput()
		}

	}
}