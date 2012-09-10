package amu.site.vo{
	import com.adobe.cairngorm.vo.IValueObject;
	[Bindable]
	public class PathItemVO implements IValueObject{
		public var id:String
		public var closedOnLevel:Boolean=false
		public var showedOnLevel:Boolean=false
		public var triggered:Boolean=false
	}
}