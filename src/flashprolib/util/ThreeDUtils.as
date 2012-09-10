package flashprolib.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix3D;

	public class ThreeDUtils
	{
		public function ThreeDUtils()
		{
		}
		public static function setDepths(v:Vector.<DisplayObject>,container:DisplayObjectContainer):void {
			var matrix:Matrix3D;
			var ar:Array=[]
			for each(var d:DisplayObject in v) {
				matrix = d.transform.getRelativeMatrix3D(container.root);
				ar.push({ref:d,z:matrix.position.z})
			}
			ar.sortOn("z", Array.NUMERIC | Array.DESCENDING);
			for(var i:uint=0;i<ar.length;i++) {
				container.addChild(ar[i].ref);
			}
		}
	}
}