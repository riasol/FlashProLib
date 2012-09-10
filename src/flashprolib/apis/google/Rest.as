package flashprolib.apis.google {
	import amu.site.tool.JsBridge;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import flashprolib.apis.IJsonDecored;
	import flashprolib.apis.google.model.ImageResultItem;
	import flashprolib.apis.google.model.ResultCursor;
	import flashprolib.apis.google.model.ResultObject;
	import flashprolib.util.DataTransform;


	public class Rest extends EventDispatcher {
		public var externalJsonDecoder:IJsonDecored
		private var loader:URLLoader;
		private var srv:AbstractSearch
		function Rest(s:AbstractSearch) {
			srv=s
		}
		public function run(q:Query,start:uint=0):void {
			loader=new URLLoader();
			loader.dataFormat=URLLoaderDataFormat.TEXT
			var req:URLRequest=new URLRequest(srv.endpoint)
			var data:URLVariables=new URLVariables();
			//data.key=GoogleApisCommon.getInstance().key;
			data.v=GoogleApisCommon.getInstance().v;
			if(GoogleApisCommon.getInstance().rsz is RszEnum){
				data.rsz=GoogleApisCommon.getInstance().rsz
			}
			data.q=q.q;
			data.start=start;
			req.data=data
			loader.data
			loader.addEventListener(Event.COMPLETE, evComplete)
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, evError)
			loader.addEventListener(IOErrorEvent.IO_ERROR, evError)
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, evError)
			loader.load(req)
		}
		private function evComplete(e:Event):void {
			var resultObj:Object
			if(externalJsonDecoder is IJsonDecored){
				resultObj=externalJsonDecoder.decode(loader.data)
			}else{
				var js:JsBridge=new JsBridge()
				resultObj=js.jsonDecode(loader.data);
			}
			var td:DataTransform=new DataTransform()
			var resultObjTyped:ResultObject=td.mapProperties(resultObj, ResultObject)
			var typedArr:Array=td.mapArray(resultObjTyped.responseData.results, ImageResultItem)
			var ev:GoogleApiEvent=new GoogleApiEvent(GoogleApiEvent.EVENT_RESULT_COMPLETE)
			ev.queryResult=typedArr
			var crs:ResultCursor=td.mapProperties(resultObj.cursor, ResultCursor)
			crs.pages=resultObj.responseData.cursor.pages
			ev.cursor=crs
			dispatchEvent(ev)
		}
		private function evError(e:Event):void {
			trace(e)
		}
	}
}