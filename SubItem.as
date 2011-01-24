package  {
	
	public class SubItem extends ScreenElement{
		private var speed:int = 10;
		public var colSpan:int;
		public var goalX:int;
		public var goalY:int;

		public function SubItem(_handler:View, _id:String, _goalX:int = 0, _goalY:int = 0) {
			super(_handler, _id);
			goalX = _goalX;
			goalY = _goalY;
		}
		
		override public function tick() {
			var vX:Number = this.x - goalX;
			var vY:Number = this.y - goalY;
			var vL:Number = Math.sqrt((vX*vX) + (vY*vY));
			var dX:Number = vX/vL;
			var dY:Number = vY/vL;
			
			if(vL > speed) {
				this.x -= (dX * speed);
				this.y -= (dY * speed);
			}
		}
	}
}
