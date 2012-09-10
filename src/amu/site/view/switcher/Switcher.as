package amu.site.view.galery
{
	import flash.display.Loader;
	import flash.display.Sprite;
	/**
	 * TODO Klasa w budowie
	 */
	public class Switcher extends Sprite
	{
		 public var loadCNT:int
		 public var loaders:Array
		 public function Switcher(){
		 	loadCNT=0
		 	addLoader()
		 	addLoader()
		 }
		 private function addLoader():void{
		 	var l:Loader=new Loader();
		 	loaders.push(l);
		 }
		 public function load(url:String):void{
		 	loadCNT++
		 	
		 }
		 
	}
}