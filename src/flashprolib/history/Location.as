package flashprolib.history {
	import flash.utils.Dictionary;
	

	public class Location {
		private var registry:Dictionary;
		function Location(){
			registry=new Dictionary()
		}
		public function store():void{
		registry
		}
		private function setTrackLevel(t:TrackLevel):void{
			registry[t.id]=t
		}
	}
}