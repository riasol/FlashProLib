package flashprolib.scenes {
	import flashprolib.commands.Command;
	import flash.events.Event;
	
	//this class handles scene transitions
	public class SceneManager {
		
		//a reference to the current scene
		private var _currentScene:Scene;
		
		//a reference to the target scene of a transition
		private var _targetScene:Scene;
		
		//dummy-proof variable
		private var _isInTransition:Boolean = false;
		
		public function SceneManager() {
			
		}
		
		public function setScene(scene:Scene):void {
			//if a transition is not finished, ignore the method invocation
			if (_isInTransition) return;
			
			_targetScene = scene;
			
			//turn on the dummy-proof variable
			_isInTransition = true;
			
			//check if a scene is already assigned to the scene manager
			if (_currentScene) {
				
				//if yes, start the ourtro of the current scene first
				var outroCommand:Command = _currentScene.createOutroCommand();
				
				//and listen for the complete event of the outro command
				outroCommand.addEventListener(Event.COMPLETE, onCurrentOutroComplete);
				outroCommand.start();
				
			} else {
				//if not, start the intro of the target scene
				gotoTargetScene();
			}
		}
		
		//invoked when the outro command of the current scene is complete
		private function onCurrentOutroComplete(e:Event):void {
			Command(e.target).removeEventListener(Event.COMPLETE, onCurrentOutroComplete);
			gotoTargetScene();
		}
		
		private function gotoTargetScene():void {
			//enable the scene manager reference of the target scene
			_targetScene._sceneManager = this;
			
			var introCommand:Command = _targetScene.createIntroCommand();
			
			//listen for the complete event of the intro command of the target scene
			introCommand.addEventListener(Event.COMPLETE, onTargetIntroComplete);
			introCommand.start();
		}
		
		//invoked when the intro command of the target scene is complete
		private function onTargetIntroComplete(e:Event):void {
			Command(e.target).removeEventListener(Event.COMPLETE, onTargetIntroComplete);
			
			//disable the scene manager reference of the previous scene
			if (_currentScene) _currentScene._sceneManager = null;
			
			//set the target scene as the current scene
			_currentScene = _targetScene;
			
			//turn off the dummy-proof variable
			_isInTransition = false;
			
			//and invoke the onSceneSet() method
			_currentScene.onSceneSet();
		}
	}
}