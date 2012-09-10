package test
{
	import amu.site.base.HTMLCommunicator;
	import amu.site.events.NavigationEvent;
	
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;
	
	import flexunit.framework.Assert;

	public class HTMLCommunicatorTest
	{
		private var htmlCommunicator:HTMLCommunicator;
		private var myTestLabel:String="testowy tytuł";
		[Before]
		public function setUp():void{
			htmlCommunicator=new HTMLCommunicator()
			if(ExternalInterface.available) {
				ExternalInterface.call('document.insertScript=function(){window._hc_getTitle=function(){' + 
						'return document.title;' + 
						'};}')
			}
		}
		[Test(async,timeout="100")] 
		public function setTitle():void{
			var ev:NavigationEvent=new NavigationEvent(NavigationEvent.EVENT_NAVIGATE);
			ev.label=myTestLabel
			ev.dispatch()
			//Async.asyncHandler( this, checkTitle,100 ); 
			setTimeout(checkTitle,50)
		}	
		private function checkTitle():void{
			if(ExternalInterface.available){
				var readed:String=ExternalInterface.call('_hc_getTitle') as String
				Assert.assertEquals(myTestLabel,readed)
			}else{
				Assert.fail('Test musi być uruchomiony w html')
			}
		}	
	}
}