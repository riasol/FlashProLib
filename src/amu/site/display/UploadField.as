package amu.site.display{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.TextInput;
	public class UploadField extends HBox{
		[Bindable]
		public var selectString:String="select";
		private var _fileReferenceInstance:FileReference
		private var inp:TextInput
		override protected function createChildren():void{
			super.createChildren();
			inp=new TextInput();
			addChild(inp)
			inp.editable=false
			inp.percentWidth=100;
			var btn:Button=new Button();
			addChild(btn)
			BindingUtils.bindProperty(btn,"label",this,"selectString")
			btn.addEventListener(MouseEvent.CLICK,evBrowseClick)
			BindingUtils.bindSetter(evErrorStringChange,this,"errorString")
		}
		private function evErrorStringChange(t:String):void{
			if(t is String){
				inp.errorString=t
			}
		}
		public function set fileReferenceInstance(v:FileReference):void{
			_fileReferenceInstance=v
			_fileReferenceInstance.addEventListener(Event.SELECT,evFilesSelect)
		}
		private function evFilesSelect(e:Event):void{
			inp.text=_fileReferenceInstance.name
			var ev:Event=new Event(Event.CHANGE)
			dispatchEvent(ev)
		}
		public function get fileName():String{
			return inp.text
		}
		private function evBrowseClick(e:MouseEvent):void{
			_fileReferenceInstance.browse()
		}
		
	}
}