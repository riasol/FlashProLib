package flashprolib.effects
{
	public interface IFPTransition
	{
		function set target(v:Object):void;
		function get target():Object;
		/**
		 * seconds
		 */
		function set duration(v:Number):void;
		function get duration():Number;
		function play():void;
		function stop():void;
	}
}