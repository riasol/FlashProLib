package flashprolib.patterns {

	public class CommandStack {
		private var stack:Array=[]
		public function add(command:IUndonableCommand):void {
			stack.push(command)
			execute()
		}
		public function execute():void { //TODO jak działa command
			(stack[stack.length - 1] as IUndonableCommand).execute()
		}
		public function undo():void {
			if(stack.length>0){
				var cmd:IUndonableCommand=stack.pop() as IUndonableCommand
				cmd.undo()
			}

		}
	}
}
