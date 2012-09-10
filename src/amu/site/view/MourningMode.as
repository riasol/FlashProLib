package amu.site.view {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.net.URLRequest;

	public class MourningMode {
		public function MourningMode(cont:DisplayObjectContainer, point:Point=null, filterObject:DisplayObject=null, path:String='http://amu.pl/modules/content/black_ribbon_73x110.png', useBW:Boolean=true) {
			if(cont.loaderInfo.parameters.hasOwnProperty('mourningMode')) {
				var ld:Loader=new Loader()
				ld.load(new URLRequest(path))
				cont.addChild(ld)
				if(point == null) {
					point=new Point()
				}
				ld.x=point.x
				ld.y=point.y
				if(useBW) {
					var matrix:Array=new Array();
					matrix=matrix.concat([0.33, 0.33, 0.33, 0, 0]); // red
					matrix=matrix.concat([0.33, 0.33, 0.33, 0, 0]); // green
					matrix=matrix.concat([0.33, 0.33, 0.33, 0, 0]); // blue
					matrix=matrix.concat([0, 0, 0, 1, 0]); // alpha
					if(filterObject == null) {
						filterObject=cont
					}
					filterObject.root.filters=[new ColorMatrixFilter(matrix)]
				}
			}
		}

	}
}