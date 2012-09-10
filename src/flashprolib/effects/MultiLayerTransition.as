package flashprolib.effects {
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	import flashprolib.util.DisplayUtils;
/*
var holder:Sprite=new Sprite()
addChild(holder)
var ld:Loader=new Loader()
holder.addChild(ld)
...
ld.contentLoaderInfo.addEventListener(Event.COMPLETE,evComplete)
...
private var ef:MultiLayerTransition
		override protected function evComplete(e:Event):void{
			if(ef==null){
			ef=new MultiLayerTransition()
			}
			ef.target=e.currentTarget.loader.parent;
			ef.duration=1.5
			ef.play()
			ef.addEventListener(FPEffectEvent.EFFECT_END,evEffectComplete)
		}
		private function evEffectComplete(e:FPEffectEvent):void{
			if(numChildren==2){
				removeChildAt(0)
			}
		}
*/
	public class MultiLayerTransition extends FPTransition {
		public function MultiLayerTransition() {
			super();
		}
		private var _target:DisplayObjectContainer
		override public function set target(v:Object):void {
			cleanup()
			_target=null;
			_target=v as DisplayObjectContainer;
		}
		private var bwBitmap:Bitmap
		private var bwMask:Sprite
		private var saturatedBitmap:Bitmap;
		private var destinationBitmap:Bitmap;
		private var blik:Sprite;
		private var placeholder:Sprite;
		private var holderName:String='MultiLayerEffectHolder';
		private var targetSize:Array;
		private var oldBitmap:Bitmap=new Bitmap();
		private var oldMask:Sprite
		private function createElements():void {
			targetSize=[_target.width, _target.height]
			placeholder=new Sprite();
			bwBitmap=DisplayUtils.cloneAsBitmap(_target);
			Tweener.addTween(bwBitmap, {_saturation:0, time:1, useFrames:true})
			var holder2:Sprite=new Sprite();
			placeholder.addChild(holder2)
			var wholeMask:Sprite=new Sprite()
			wholeMask.graphics.beginFill(0x000000)
			wholeMask.graphics.drawRect(0, 0, targetSize[0], targetSize[1])
			wholeMask.graphics.endFill()
			placeholder.addChild(wholeMask)
			holder2.mask=wholeMask
			bwMask=new Sprite()
			bwMask.graphics.beginFill(0x000000)
			bwMask.graphics.drawRect(0, 0, targetSize[0], targetSize[1])
			bwMask.graphics.endFill()
			holder2.addChild(bwMask)
			bwBitmap.mask=bwMask
			bwBitmap.visible=false
			saturatedBitmap=DisplayUtils.cloneAsBitmap(_target);
			saturatedBitmap.visible=false
			Tweener.addTween(saturatedBitmap, { _saturation:4, alpha:0.3, time:1 ,useFrames:true})
			destinationBitmap=DisplayUtils.cloneAsBitmap(_target);
			destinationBitmap.visible=false
			blik=new Sprite();
			blik.visible=false
			blik.blendMode=BlendMode.OVERLAY
			DisplayUtils.prepareGradient(blik.graphics, targetSize[0]/3, targetSize[1]
				, [0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF]
				, [0, 1, 1, 0]
				, [0, 127, 220, 255]
				)
			blik.graphics.drawRect(0, 0, targetSize[0], targetSize[1])
			oldBitmap.visible=false
			oldMask=new Sprite()
			oldMask.graphics.beginFill(0x000000)
			oldMask.graphics.drawRect(0, 0, targetSize[0]/15, targetSize[1])
			oldMask.graphics.endFill()
			holder2.addChild(oldMask)
				oldBitmap.mask=oldMask
			removedChildren=[]
			for(var i:int=_target.numChildren-1;i>=0;i--){
				removedChildren.push(_target.getChildAt(i))
				_target.removeChildAt(i)
			}
			DisplayUtils.removeAllChildren(_target)
			placeholder.name=holderName;
			holder2.addChild(saturatedBitmap)
			holder2.addChild(destinationBitmap)
			holder2.addChild(bwBitmap)
			holder2.addChild(blik)
			holder2.addChild(oldBitmap)	
			oldBitmap.cacheAsBitmap=saturatedBitmap.cacheAsBitmap=destinationBitmap.cacheAsBitmap=bwBitmap.cacheAsBitmap=blik.cacheAsBitmap=true
			_target.addChild(placeholder);
		}
		private var removedChildren:Array;
		private function animate():void {
			var firstHalf:Number=duration *0.3
			blik.x=blik.width * -1/2
			Tweener.addTween(blik, {x:blik.x+targetSize[0], time:firstHalf, transition:'easeInCubic'
					, onStart:function():void {
					this.visible=true
				}
				, onStartScope:blik
				,onComplete:function():void{
					this.visible=false
				}
				,onCompleteScope:blik
				})
			bwMask.x=-targetSize[0];
			Tweener.addTween(bwMask, {x:0, time:firstHalf, transition:'easeOutCubic'
					, onStart:function():void {
					this.visible=true
				}
				, onStartScope:bwMask
				})
			bwBitmap.x=-targetSize[0] / 4
			Tweener.addTween(bwBitmap, {x:0, time:firstHalf, transition:'easeOutCubic'
				, onStart:function():void {
					this.visible=true
				}
				, onStartScope:bwBitmap
			})
				//2 part
				oldMask.x=targetSize[0]
			Tweener.addTween(oldMask, {x:-targetSize[0]/15, time:duration -firstHalf , delay:firstHalf
				, transition:'easeOutCubic'
				, onStart:function():void {
					this.visible=true
				}
				, onStartScope:oldBitmap
			})
			Tweener.addTween(bwMask, {x:-targetSize[0], time:duration -firstHalf, delay:firstHalf
				, transition:'easeOutCubic'
				, onStart:function():void {
					this.x=-1/8*targetSize[0]
				}
				, onStartScope:bwMask	
			})
			destinationBitmap.x=-targetSize[0] / 8
			destinationBitmap.alpha=0
			Tweener.addTween(destinationBitmap, {x:0,alpha:1, time:duration -firstHalf , delay:firstHalf
				, transition:'easeOutExpo'
				, onStart:function():void {
					this.visible=true
				}
				, onStartScope:destinationBitmap
			})
			saturatedBitmap.x=targetSize[0] / 8
			Tweener.addTween(saturatedBitmap, {x:0, _saturation:0.6, alpha:1, time:duration -firstHalf, delay:firstHalf
				, transition:'easeOutExpo'
				, onStart:function():void {
					this.visible=true
				}
				, onStartScope:saturatedBitmap
				, onComplete:function():void {
					dispatchEvent(new FPEffectEvent(FPEffectEvent.EFFECT_END))
				}
				, onCompleteScope:this
			})
		}
		private function cleanup():void {
			if(_target && _target.getChildByName(holderName)) {
				_target.removeChild(placeholder)
				for each(var remChild:DisplayObject in  removedChildren){
					_target.addChild(remChild)
				}
			}
		}
		override public function get target():Object {
			return _target;
		}
		override public function play():void {
			createElements()
			animate()
		}
		override public function stop():void {
			Tweener.removeTweens(bwBitmap)
			Tweener.removeTweens(bwMask)
			Tweener.removeTweens(saturatedBitmap)
			Tweener.removeTweens(destinationBitmap)
			Tweener.removeTweens(oldMask)
		}
		public function set previousDisplay(d:DisplayObject):void{
			oldBitmap=DisplayUtils.cloneAsBitmap(d);
		}

	}
}