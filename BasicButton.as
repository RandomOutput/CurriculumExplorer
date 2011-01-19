package  {
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class BasicButton extends ScreenElement{
		private const HOLD_TIME:int = 2500;
		private var startTime:int;
		private var link:String;

		public function BasicButton(_handler:View, _id:String, _xLoc:int, _yLoc:int, _link:String) {
			// constructor code
			super(_handler, _id, _xLoc, _yLoc);
			link = _link;
			this.addEventListener(Event.ADDED_TO_STAGE, startLife);
		}
		
		public function startLife(e:Event) {
			this.removeEventListener(Event.ADDED_TO_STAGE, startLife);
			startTime = getTimer();
		}
		
		override public function tick() {
			/*trace("Button ID: " + this.id + " - parent: " + this.parent);
			trace("Button ID: " + this.id + " - handler: " + handler);
			trace("Button ID: " + this.id + " - handler.handler: " + handler.handler);
			trace("Button ID: " + this.id + " - handler.handler.inputHandler: " + handler.handler.inputHandler);*/
			for each(var testPoint:Point in handler.handler.inputHandler.getInputs()){
				if(this.hitTestPoint(testPoint.x, testPoint.y) && ((getTimer() - startTime >= HOLD_TIME))) {
					if(link.substr(link.length-4, 4) == ".xml"){
						handler.handler.loadView(link);
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
