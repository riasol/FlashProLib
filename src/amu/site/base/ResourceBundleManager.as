package amu.site.base{
	import amu.site.events.ResourceBundleEvent;
	import amu.site.model.SiteModelLocator;

	import mx.resources.ResourceManager;


	public class ResourceBundleManager{
		public static const codesMap:Object={pl:'pl_PL',en:'en_US'}
		private static var instance:ResourceBundleManager
		public static function getInstance():ResourceBundleManager{
			if(instance==null){
				instance=new ResourceBundleManager()
				ResourceManager.getInstance().localeChain=[codesMap[SiteModelLocator.getInstance().lang]]
			}
			return instance;
		}
		public function loadResource(groupId:String):void{
			var ev:ResourceBundleEvent=new ResourceBundleEvent(ResourceBundleEvent.EVENT_LOAD_TRANSLATION_GROUP)
				ev.groupId=groupId
				ev.dispatch()
		}

	}
}