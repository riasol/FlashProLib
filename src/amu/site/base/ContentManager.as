package amu.site.base{
	import amu.site.events.ContentEvent;

	import cms2.site.vo.PageRequestVO;

	import com.adobe.cairngorm.control.CairngormEventDispatcher;

	import flashprolib.util.CoreUtils;


	public class ContentManager{
		private var pages:Array
		private static var instance:ContentManager;
		public  var cachePages:Boolean=true;
		private var pageRequestUids:Object={}
		function ContentManager(){
			pages=new Array();
			CairngormEventDispatcher.getInstance().addEventListener(ContentEvent.EVENT_PAGE_LOADED,evPageLoaded)
		}
		public static function getInstance():ContentManager{
			if(instance==null){
				instance=new ContentManager();
			}
			return instance;
		}
		public function getPage(pr:PageRequestVO):PageRequestVO{
			for each(var p:PageRequestVO in pages){
				if(p.lang==pr.lang && p.id_page==pr.id_page){
					var parOk:Boolean=true
					var parName:String
					for(parName in pr.getParams){
						if(p.getParams[parName]!=pr.getParams[parName]){
							parOk=false;
							break
						}
					}
					for(parName in p.getParams){
						if(p.getParams[parName]!=pr.getParams[parName]){
							parOk=false;
							break
						}
					}
					if(parOk){
						return p
					}
				}
			}
			return null
		}
		public function asyncLoad(pr:PageRequestVO):void{
			pageRequestUids[pr.id_page]=pr.uid
			var p:PageRequestVO=getPage(pr)
			if(p!=null){
				dispatchAvailableEvent(p)
			}else{
				prefetch(pr)
			}
		}
		private function evPageLoaded(e:ContentEvent):void{
			dispatchAvailableEvent(e.pageRequest)
		}

		private function dispatchAvailableEvent(pr:PageRequestVO):void{
			var ev:ContentEvent=new ContentEvent(ContentEvent.EVENT_PAGE_AVAILABLE)
			pr.uid=pageRequestUids[pr.id_page]
			ev.pageRequest=pr
			ev.dispatch()
		}
		public function prefetchLevel(xml:XML,template:PageRequestVO,idOfCompleteRequest:String='pages'):void{
			var pages:Array=[]
			for each(var xItem:XML in xml.item) {
				var pr:PageRequestVO=CoreUtils.clone(template) as PageRequestVO;
				//pr.lang=SiteModelLocator.getInstance().lang
				pr.id_page=xItem.@id
				//pr.transform_content=true
				//pr.daoClassName="fromPage"
				pages.push(pr)
			}
			prefetchArray(pages, idOfCompleteRequest)
		}
		public function prefetchArray(pages:Array,requestId:String=null):void{
			var ar2:Array=new Array();
			var toKill:Array=[]
			for each(var pr:PageRequestVO in pages){
				var testPage:PageRequestVO=getPage(pr)
				if(testPage==null || !cachePages){
					ar2.push(pr)
					if(testPage is PageRequestVO && !cachePages){
						toKill.push(testPage)
					}
				}
			}
			if(toKill.length>0){
				for each(var pk:PageRequestVO in toKill){
					for(var i:int=0;i<this.pages.length;i++){
						/*if(getPage(pk)!=null){
							this.pages.splice(i,1)
							break
						}*/
					}
				}
			}
			if(ar2.length>0){
				var ev:ContentEvent=new ContentEvent(ContentEvent.EVENT_LOAD_PAGES);
				ev.requestId=requestId
				ev.pages=ar2
				ev.dispatch()
			}

		}
		public function prefetch(pr:PageRequestVO,requestId:String=null):void{
			if(getPage(pr)==null){
				var ev:ContentEvent=new ContentEvent(ContentEvent.EVENT_LOAD_PAGE);
				ev.pageRequest=pr
				ev.requestId=requestId
				ev.dispatch()
			}
		}
		public function push(pr:PageRequestVO):void{
			if(cachePages){
				pages.push(pr)
			}
		}
	}
}