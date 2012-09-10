package amu.site.commands{
	import amu.site.assets.IRuntimeAssets;
	import amu.site.events.AssetEvent;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.System;
	
	import flashprolib.util.IoUtils;
	
	import mx.managers.CursorManager;



	public class LoadAssetCommand extends AbstractCommand{
		private var savedEvent:AssetEvent
		private var loader:Loader
		override public  function execute(e:CairngormEvent):void
			{
				savedEvent=e as AssetEvent
				var path0:String
				if(savedEvent.assetName.indexOf('/')>-1){//full path
					path0=savedEvent.assetName
				}else{
					path0="/modules/assets/"+savedEvent.assetName+".swf";
				}
				path0+=(path0.indexOf('?')>-1?'&':'?')+'modified='+ExternalInterface.call('cms2.siteSwf.getConfig').page_modified_stamp
				var path:URLRequest=new URLRequest(path0)
				var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,evAssetsLoadComplete);
				IoUtils.ioErrorsGuard(loader.contentLoaderInfo)
				loader.load(path,context);
				var ev:AssetEvent=new AssetEvent(AssetEvent.EVENT_ASSET_LOAD_START)
				ev.loader=loader
				ev.dispatch()
				CursorManager.getInstance().setBusyCursor()
			}
		private function evAssetsLoadComplete(e:Event):void{
				var ev:AssetEvent=new AssetEvent(AssetEvent.EVENT_ASSET_LOADED);
				ev.asset=e.target.content as IRuntimeAssets
				if(e.target.content is MovieClip){
					MovieClip(e.target.content).stop()
					MovieClip(e.target.content).visible=false
				}
				ev.assetName=savedEvent.assetName
				ev.loader=loader
				ev.dispatch();
				CursorManager.getInstance().removeBusyCursor()
		}
	}
}