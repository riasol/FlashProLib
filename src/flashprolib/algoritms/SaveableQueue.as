package flashprolib.algoritms
{
	import flashprolib.util.SimpleSharedObject;
	/**
	 * Using:
	 * private var sq:SaveableQueue
	 * sq=new SaveableQueue('SaveableQueue',myLength)
	 * var idx:Number=sq.next()
	 * var idx:Number=sq.previous()
	 * var idx:Number=sq.current()
	 * sq.storeIndex()
	 */ 
	public class SaveableQueue
	{
		private var so:SimpleSharedObject;
		private var qLength:Number
		private var index:Number
		public function SaveableQueue(soName:String,qLength:Number)
		{
			so=new SimpleSharedObject(soName)
			this.qLength=qLength
			var queueLength:*=so.read('queueLength')
			index=0
			if(queueLength!=null){
				if(Number(queueLength)==qLength){
					index=Number(so.read('imageIndex'))
				}
			}
			so.save('queueLength',qLength)
		}
		public function next():Number{
			index++
			if(index>=qLength){
				index=0
			}
			return index
		}
		public function previous():Number{
			index--
			if(index<0){
				index=qLength-1
			}
			return index
		}
		public function current():Number{
			return index
		}
		public function storeIndex():void{
			so.save('imageIndex',index)
		}

	}
}