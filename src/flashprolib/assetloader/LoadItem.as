package flashprolib.assetloader
{
	import flash.utils.getTimer;

	public class LoadItem
	{
		public var path:String;
		public var priority:int;
		public var bytesLoaded:Number;
		public var bytesTotal:Number;
		public var loaded:Boolean;
		public var time:int;
		public function LoadItem(path:String,priority:int=0)
		{
			this.path=path;
			this.priority=priority;
			time=getTimer();
			bytesLoaded=bytesTotal=0;
			loaded=false
		}

	}
}