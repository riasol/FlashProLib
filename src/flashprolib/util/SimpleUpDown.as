package flashprolib.util {
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;


	public class SimpleUpDown {
		public function saveData(d:*,name:String):void{
			var fr:FileReference=new FileReference()
			fr.save(d,name)
		}
		private var dataType:String;
		private var readClb:Function;
		/**
		 * [new FileFilter('preferences', '*.*')]
		 */ 
		public function readData(filters:Array,readClb:Function,dataType:String):void{
			this.readClb=readClb
				this.dataType=dataType
			var fr:FileReference=new FileReference()
			fr.addEventListener(Event.COMPLETE,evFileComplete)
			fr.browse(filters)
			fr.addEventListener(Event.SELECT,function (e:Event):void{
				fr.load()
			})
		}
		private function evFileComplete(e:Event):void{
			var ba:ByteArray=FileReference(e.currentTarget).data
			var data:*
				if(dataType=='String'){
				data	= ba.readUTFBytes(ba.length)
				}
				readClb.call(readClb,data)
		}
	}
}