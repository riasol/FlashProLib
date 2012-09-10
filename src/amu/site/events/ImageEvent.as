package amu.site.events
{
	
	import cms2.site.vo.ImageVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	

	public class ImageEvent extends CairngormEvent
	{
		public static const EVENT_IMAGE_MINIATURE_CLICK:String="EVENT_IMAGE_MINIATURE_CLICK";
		public var image:ImageVO
		function ImageEvent(type:String){
			super(type)
		}
	}
}