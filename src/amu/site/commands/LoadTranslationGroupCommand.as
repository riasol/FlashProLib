package amu.site.commands{
	import amu.site.base.ResourceBundleManager;
	import amu.site.business.SiteDelegate;
	import amu.site.events.ResourceBundleEvent;
	import amu.site.model.SiteModelLocator;

	import com.adobe.cairngorm.control.CairngormEvent;

	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;

	public class LoadTranslationGroupCommand extends AbstractCommand{
		private var curGroupId:String
		override public  function execute(e:CairngormEvent):void
			{
				curGroupId=ResourceBundleEvent(e).groupId
				new SiteDelegate(this).getTranslationGroup(curGroupId)
			}
		override public function result( e:Object ) : void
			{
				var ar:Array=e.result as Array;
				var rb:ResourceBundle = new ResourceBundle(ResourceBundleManager.codesMap[SiteModelLocator.getInstance().lang], curGroupId);
				for each(var el:Array in ar){
					rb.content[el[0]] = el[1];
				}
				ResourceManager.getInstance().addResourceBundle(rb);
				ResourceManager.getInstance().update();
				var ev:ResourceBundleEvent=new ResourceBundleEvent(ResourceBundleEvent.EVENT_TRANSLATION_GROUP_LOADED)
				ev.groupId=curGroupId
				ev.dispatch()
			}
	}
}