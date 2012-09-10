package amu.site.tool.reload {
	import flash.display.DisplayObject;
	import flash.display.Loader;
	
	import flashprolib.util.SimpleSharedObject;
	
	import mx.core.Application;
	import mx.modules.ModuleLoader;

	public class Version {
		private var loadedObject:DisplayObject;
		private var _timeout:int=60000;
		private var requiredVersion:String;
		public function Version(object:DisplayObject) {
			loadedObject=object
		}
		/**
		 * 
		 * @param v miliseconds before next  reload available
		 * 
		 */		
		public function set timeout(v:int):void{
			_timeout=v
		}
		/**
		 *
		 * @param requiredVersion
		 * @return true if has required version or objectVersion property not found
		 *
		 */
		public function compare(requiredVersion:String):Boolean {
			this.requiredVersion=requiredVersion
			var toCompare:String='';
			//loadedObject.loaderInfo. bytes tactics
			if(loadedObject.hasOwnProperty('objectVersion')) {
				toCompare=loadedObject['objectVersion'] as String
			}else if(loadedObject is Loader && Loader(loadedObject).content.hasOwnProperty('objectVersion')){
				 toCompare=Loader(loadedObject).content['objectVersion'] as String
			}else if(loadedObject is ModuleLoader && ModuleLoader(loadedObject).child.hasOwnProperty('objectVersion')){
				 toCompare=ModuleLoader(loadedObject).child['objectVersion'] as String
			}
			if(toCompare == requiredVersion || toCompare == '') {
				return true
			}
			return false;
		}
		/**
		 *
		 *Reload if possible
		 */
		public function reload():void {
			var objectUrl:String
			if(loadedObject  is Application){
				objectUrl=Application(loadedObject).url
			}else if(loadedObject  is ModuleLoader){
				objectUrl=ModuleLoader(loadedObject).url
			}else if(loadedObject  is Loader){
				objectUrl=Loader(loadedObject).contentLoaderInfo.url
			}
			if(objectUrl.indexOf('?')>-1){
				objectUrl=objectUrl.substring(0,objectUrl.indexOf('?'))
			}
			objectUrl=objectUrl.replace(new RegExp("[/:\.]",'g'),'_')
			var so:SimpleSharedObject=new SimpleSharedObject(objectUrl);
			var time:Number=so.read('timer') as Number;
			var d:Date=new Date()
			var msecs:Number=d.time
			so.save('timer',msecs)
			if(time is Number && (msecs-time)<_timeout){
				return 
			}
			var reload:Reloader=new Reloader(loadedObject);
		}
	}
}