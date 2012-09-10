package flashprolib.particles
{
	import flash.utils.getTimer;
	
	import flashprolib.algoritms.Physics;

	public class AntigravityCalculator implements IParticleMotionCalculator
	{
		public function AntigravityCalculator()
		{
		}
		
		public function calculate(p:Particle):void
		{
			var t:Number=(getTimer()-p.t0)/1000
			p.item.x=Physics.sGravity(t,p.s0[0],p.v0[0])
			p.item.y=Physics.sGravity(t,p.s0[1],p.v0[1])
			p.item.z=Physics.sGravity(t,p.s0[2],p.v0[2],-30);//trace(p.item.z)

		}
	}
}