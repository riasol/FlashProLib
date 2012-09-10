package flashprolib.util {
	import flash.display.DisplayObject;

/*
 * Instance is source of properties
 */
	public class PrimitivesSource {
		public function getNumber(k:String):Number{
			return Number(this[k])
		}
		public function getString(k:String):String{
			return String(this[k])
		}
		public function getBoolean(k:String):Boolean{
			return Boolean(this[k])
		}
		/**
		 * Defaults as a='x,y'
		 */
		public function getArray(k:String):Array{
			return String(this[k]).split(",")
		}
		public function setValues(params:Object):void{
			for(var p:String in params){
				setValue(p,params[p])
			}
		}
		public function fromSwfParameters(s:DisplayObject):void{
			setValues(s.loaderInfo.parameters)
		}
		public function setValue(k:String,v:String):void{
			if(!hasOwnProperty(k)){
				return
			}
			var isVar:Boolean=false
			if(v=="true" || v=="false"){
				this[k]=v=="true"
				return
			}
			var n:Number=Number(v)
			if(!isNaN(n)){
				this[k]=n
				return
			}
			this[k]=v
		}
	}
}