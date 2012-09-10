package flashprolib.scenes {
	import flashprolib.commands.Command;
	import flashprolib.commands.utils.Dummy;
	
	//this class represents a scene for a complete Flash application
	public class Scene {
		
		//a reference to the scene manager owning this scene
		internal var _sceneManager:SceneManager;
		protected final function get sceneManager():SceneManager { return _sceneManager; }
		
		//creates the intro command of this scene
		public function createIntroCommand():Command {
			return new Dummy();
		}
		
		//creates the outro command of this scene
		public function createOutroCommand():Command {
			return new Dummy();
		}
		
		//handle scene-related stuff here when the scene is set
		public function onSceneSet():void {
			
		}
	}
}