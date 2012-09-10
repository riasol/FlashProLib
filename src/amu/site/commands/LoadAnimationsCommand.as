package amu.site.commands{
	import amu.site.base.AnimationManager;
	import amu.site.business.SiteDelegate;
	import amu.site.events.AnimationEvent;
	import amu.site.events.NavigationEvent;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	

	public class LoadAnimationsCommand extends AbstractCommand{
		override public  function execute(e:CairngormEvent):void
			{	
				new SiteDelegate(this).loadAnimations(AnimationEvent(e).keys)
			}
		override public function result( e:Object ) : void
			{		
				var ar:Array=e.result as Array;
				for each(var el:Array in ar){
					AnimationManager.getInstance().push(el[0],el[1])
				}
			} 
	}
}