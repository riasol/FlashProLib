package flashprolib.particles {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import flashprolib.algoritms.Physics;
	import flashprolib.util.MathExtensions;
	public class Particles {
		public var maxItems:int=20
		public var maxLifeTime:int=20
		/**
		 * Powierzchnia startu
		 */
		private var hitArea:DisplayObject;
		private var motionCalculator:IParticleMotionCalculator
		private var rect:Rectangle;
		private var registry:Array=[]

		public function Particles(hitArea:DisplayObject, rect:Rectangle, motionCalculator:IParticleMotionCalculator) {
			this.hitArea=hitArea
			this.rect=rect
			this.motionCalculator=motionCalculator
		}

		public function generate(item:Sprite):void {
			if(registry.length < maxItems) {
				item.x=MathExtensions.randomInRange(rect.x, rect.x + rect.width)
				item.y=MathExtensions.randomInRange(rect.y, rect.y + rect.height)
				hitArea.parent.addChild(item)
				if(item.hitTestObject(hitArea)) {
					item.cacheAsBitmap=true
					var p:Particle=new Particle()
					p.item=item
					p.t0=getTimer()
					p.s0[0]=item.x
					p.s0[1]=item.y
						var vM:Number=150
							var si:int=MathExtensions.randomSign()
					p.v0=[MathExtensions.randomInRange(0.5*vM,vM)*si,MathExtensions.randomInRange(0.5*vM,vM)*si,MathExtensions.randomInRange(-5*vM,vM)]	
					registry.push(p)
				} else {
					hitArea.parent.removeChild(item)
				}
			}
		}

		public function move():void {
			for(var i:int=registry.length - 1; i >= 0; i--) {
				if((getTimer() - registry[i].t0) / 1000 > MathExtensions.randomInRange(0.3*maxLifeTime,maxLifeTime)) {
					hitArea.parent.removeChild(registry[i].item)
					registry.splice(i, 1)
					continue
				}
				motionCalculator.calculate(registry[i] as Particle)
			}
		}
	}
}