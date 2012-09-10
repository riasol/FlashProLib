package flashprolib.containers {
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import flashprolib.util.ArrayExtensions;

	import mx.utils.ArrayUtil;

	public class Table extends Sprite {
		private var cols:uint
		private var cells:Array;
		private var columnsWidth:Array
		public function Table(cols:uint) {
			super();
			columnsWidth=[]
			ArrayExtensions.fill(columnsWidth, function():uint {return 0}, cols)
			cells=[]
			this.cols=cols
		}
		public function setColumnWidth(col:uint, width:Number):void {
			columnsWidth[col]=width
			size()
		}
		private function size():void {
			for(var i:uint=0; i < cells.length; i++) {
				for(var j:uint=0; j < cells[i].length; j++) {
					cells[i][j].x=j == 0 ? 0 : columnsWidth[j - 1]
					cells[i][j].y=i * rowHeight
				}
			}
		}
		private var rowHeight:Number=16
		public function setRowHeight(h:Number):void {
			rowHeight=h
			size()
		}
		public function getCell(col:uint, row:uint):DisplayObject {
			return cells[row][col] as DisplayObject
		}
		public function addRow(content:Array):void {
			var row:Array=[]
			for(var i:uint=0; i < cols; i++) {
				var container:Sprite=new Sprite()
				if(i < content.length && content[i] is DisplayObject) {
					container.addChild(content[i] as DisplayObject)
				}
				row.push(container)
				addChild(container)
			}
			cells.push(row)
		}
	}
}