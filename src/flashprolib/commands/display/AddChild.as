package flashprolib.commands.display {
	import flashprolib.commands.Command;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	//This command encapsulates the addChild() method
	public class AddChild extends Command {
		
		public var container:DisplayObjectContainer;
		public var displayObject:DisplayObject
		
		public function AddChild(container:DisplayObjectContainer, displayObject:DisplayObject) {
			this.container = container;
			this.displayObject = displayObject;
		}
		
		override protected function execute():void {
			container.addChild(displayObject);
			complete();
		}
	}
}