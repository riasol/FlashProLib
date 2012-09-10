package flashprolib.util
{
	import flash.display.Graphics;

	public class DrawingUtils
	{
		public static function drawCurve(target:Graphics,origin:String,points:String):void {
			var originPoints:Array=origin.split(',')
			originPoints[0]=Number(originPoints[0]);originPoints[1]=Number(originPoints[1])
			var pathPoints:Vector.<Number>=new Vector.<Number>()
			pathPoints.push(originPoints[0])
			pathPoints.push(originPoints[1])	
			var c1:Array=points.split(' ')
			var commands:Vector.<int>=new Vector.<int>()
			commands.push(GraphicsPathCommand.MOVE_TO)
			var i:int=0
			for each(var s:String in c1){
				var rec:Array=s.split(',')
				rec[0]=pathPoints[0]+Number(rec[0])
				rec[1]=pathPoints[1]+Number(rec[1])
				i++
					pathPoints.push(rec[0])
				pathPoints.push(rec[1])
				
				commands.push(GraphicsPathCommand.CURVE_TO)
			}
			target.drawPath(commands,pathPoints)
		}
	}
}