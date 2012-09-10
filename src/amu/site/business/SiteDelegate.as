package amu.site.business{
	import amu.site.model.SiteModelLocator;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AbstractService;
	import mx.rpc.IResponder;


	public class SiteDelegate{
		private var responder:IResponder;
		private var service :AbstractService
		function SiteDelegate(rp:IResponder){
			responder=rp 
			service=ServiceLocator.getInstance().getRemoteObject( "SiteService" )
		}
		public function loadSitemap() : void{	
				var call : Object=service.publicGetSitemap(SiteModelLocator.getInstance().lang);
				call.addResponder( responder );
			}
		public function getPage(page:PageRequestVO) : void{	
				var call : Object=service.publicGetPage(page);
				call.addResponder( responder );
			}
		public function getPages(pages:Array) : void{	
				var call : Object=service.publicGetPages(pages);
				call.addResponder( responder );
			}
		public function query(page:PageRequestVO) : void{	
				var call : Object=service.publicQuery(page);
				call.addResponder( responder );
			}
		public function loadAnimations(ids:Array) : void{	
				var call : Object=service.publicGetAnimations(ids);
				call.addResponder( responder );
			}
		public function getTranslationGroup(id:String) : void{	
				var call : Object=service.publicGetTranslationGroup(id,SiteModelLocator.getInstance().lang);
				call.addResponder( responder );
			}		
		}
}