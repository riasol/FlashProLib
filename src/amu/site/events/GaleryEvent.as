package amu.site.events
{
	
	import cms2.site.vo.ImageVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	

	public class GaleryEvent extends CairngormEvent
	{
		public static const EVENT_GALERY_MINIATURE_SELECT :String="EVENT_GALERY_MINIATURE_SELECT";
		public static const EVENT_GALERY_IMAGE_SHOWED :String="EVENT_GALERY_IMAGE_SHOWED";
		public static const EVENT_GALERY_SCROLL_ARROW_CLICK :String="EVENT_GALERY_SCROLL_ARROW_CLICK";
		public static const EVENT_GALERY_NEW_IMAGE_SELECT :String="EVENT_GALERY_NEW_IMAGE_SELECT";
		public var image:ImageVO
		public var imageIndex:int
		public var direction:int
		public var imagesCount:int
		function GaleryEvent(type:String){
			super(type)
		}
	}
}