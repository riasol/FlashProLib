package flashprolib.patterns
{
	public interface IUndonableCommand
	{
		function execute();
		function undo();
	}
}