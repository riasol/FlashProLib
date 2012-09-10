package flashprolib.util
{
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	
	public class SimpleSharedObject
	{
		private var so:SharedObject
		/**
		* @param name Yust name of SO, creates namespace for grouping domain specific properties
		*/
		function SimpleSharedObject(name:String){
			so=SharedObject.getLocal(name)
		}
		/**
		 * @param name Name of the property
		 * @param defaultVal Default value
		 */
		public function read(name:String, defaultVal:*=null):*{
			var v:*=so.data[name];
			if(defaultVal!=null){
				if(v==null){
					v=defaultVal
					save(name,v)
				}
			}
			return v
		}
		public function save(name:String,value:*,flushNow:Boolean=true):void{
			so.data[name]=value
			if(flushNow){
				so.flush()
			}
		}
		/**
		 * Delete whole SO
		 */ 
		public function clear():void{
			so.clear()
		}
		public function toByteArray():ByteArray{
			var ba:ByteArray=new ByteArray()
				ba.writeObject(so.data)
				return ba;
		}
	}
}