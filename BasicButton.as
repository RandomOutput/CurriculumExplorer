package  {
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class BasicButton extends ScreenElement{
		private const HOLD_TIME:int = 2500;
		private var startTime:int;
		private var link:String;

		public function BasicButton(_handler:ViewHandler, _id:String, _xLoc:int, _yLoc:int, _link:String) {
			// constructor code
			super(_handler, _id, _xLoc, _yLoc);
			link = _link;
			this.addEventListener(Event.ADDED_TO_STAGE, startLife);
		}
		
		public function startLife() {
			this.removeEventListener(Event.ADDED_TO_STAGE, startLife);
			startTime = getTimer();
		}
		
		override public function tick() {
			for each(var testPoint:Point in handler.inputHandler.getInputs()){
				if(this.hitTestPoint(testPoint.x, testPoint.y) && ((getTimer() - startTime >= HOLD_TIME))) {
					if(link.substr(link.length-4, 4) == ".xml"){
						handler.loadView(link);
					}
					else {
						clickAction();
					}
				}
			}
		}
		
		protected function clickAction():void {
			
		}
	}
}
