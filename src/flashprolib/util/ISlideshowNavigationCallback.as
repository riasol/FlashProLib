package flashprolib.util
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public interface ISlideshowNavigationCallback
	{
		function onSlideshowNavigationCloseClick():void
		function animateSlideshowNavigationControll(control:DisplayObject,previousVisibility:Boolean):void
			
	}
}