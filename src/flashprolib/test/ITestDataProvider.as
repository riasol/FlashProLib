package flashprolib.test
{
	import mx.collections.ICollectionView;

	public interface ITestDataProvider
	{
		function generate():ICollectionView;
	}
}