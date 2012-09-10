package flashprolib.commands {
	import flash.events.Event;
	
	public class ParallelCommand extends Command {
		
		private var _commands:Array;
		
		public function ParallelCommand(delay:Number, ...commands) {
			super(delay);
			if( commands[0] is Array && commands.length==1){
				_commands = commands[0];
			}else{
				_commands = commands;
			}
		}
		
		private var _completeCommandCount:int;
		
		override final protected function execute():void {
			
			//set the complete command count to zero
			_completeCommandCount = 0;
			
			for each (var command:Command in _commands) {
				
				//listen for the complete event of a subcommand...
				command.addEventListener(Event.COMPLETE, onSubcommandComplete);
				
				//...and start the subcommand
				command.start();
			}
		}
		
		private function onSubcommandComplete(e:Event):void {
			
			//stop listening for the complete event
			Command(e.target).removeEventListener(Event.COMPLETE, onSubcommandComplete);
			
			//increment the complete command count
			_completeCommandCount++;
			
			//if all the commands are complete...
			if (_completeCommandCount == _commands.length) {
				
				//...then this parallel command is complete
				complete();
			}
		}
	}
}