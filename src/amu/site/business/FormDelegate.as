package amu.site.business{
	import amu.site.view.ServiceProgress;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	import flashprolib.util.CoreUtils;

	public class FormDelegate extends EventDispatcher{
		private var fileRefList:Array;
		private var filesSelected:Array
		private var data:Object;
		private var sendingID:String;
		private var filesNr:Number;
		private var filesIdx:Number;
		private var scriptPath:String="/modules/amfphp2/services/cms2/FormService.php";
		public static const dataSend:String="dataSend"
		private var completeProcessor:String;
		[Event(name="dataSend", type="flash.events.Event")]
		function FormDelegate(){
			data={}
			fileRefList=[]
		}
		public function addData(key:String,value:String):void{
			if(value !=null && value!=''){
				data[key]=value
			}
		}
		public function nextFileReference(key:String):FileReference{
			var fr:FileReference=new FileReference()
			fileRefList.push([key,fr])
			return fr
		}
		public function setCompleteProcessor(id:String):void{
			completeProcessor=id
		}
		public function send():void{
			filesSelected=[]
			for(var i:int=0;i<fileRefList.length;i++){
				var fr:FileReference=fileRefList[i][1] as FileReference
				try{
					if(fr.name!=""){
						filesSelected.push(fileRefList[i])
					}
				}catch(e:Error){

				}
			}
			filesNr=filesSelected.length
			filesIdx=0
			sendingID=CoreUtils.generateUnique()
			sendPortion()
		}
		private function sendPortion():void{
			if(filesIdx<=filesNr){
				var sendFileRef:FileReference
				var variables:URLVariables=new URLVariables()
				variables.sendingID=sendingID
				if(filesIdx<filesNr){//file
					sendFileRef=FileReference(filesSelected[filesIdx][1])
					variables.fileKey=filesSelected[filesIdx][0]
				}
				var request:URLRequest=new URLRequest(scriptPath)
				request.method = URLRequestMethod.POST;
				if(filesIdx==filesNr){
					variables.dataComplete="true"
					variables.completeProcessor=completeProcessor
					for(var p:String in data){
						variables[p]=data[p]
					}
				}
				request.data=variables
				filesIdx++;
				ServiceProgress.getInstance().callStart()
				if(sendFileRef!=null){
					sendFileRef.addEventListener(Event.COMPLETE,evRequestComplete)
					sendFileRef.upload(request)
				}else{
					var loader:URLLoader=new URLLoader()
					loader.addEventListener(Event.COMPLETE,evRequestComplete)
					loader.load(request)
				}

			}else{
				dispatchEvent(new Event("dataSend"))
			}
		}
		private function evRequestComplete(e:Event):void{
			ServiceProgress.getInstance().callFinish()
			sendPortion()
		}

	}
}