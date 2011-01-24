package  {
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class BasicButton extends ScreenElement{
		private const HOLD_TIME:int = 750;
		private var startTime:int;
		private var link:String;
		private var clickActive:Boolean;

		public function BasicButton(_handler:View, _id:String) {
			// constructor code
			super(_handler, _id);
			clickActive = false;
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
			var inputs:Vector.<Point> = handler.handler.inputHandler.getInputs();
			for (var i:int=0;i<inputs.length;i++){
				if(this.hitTestPoint(inputs[i].x, inputs[i].y) && ((getTimer() - startTime >= HOLD_TIME))) {
					if(!clickActive) {
						clickActive = true;
						clickAction();
					}
				} else if(i == inputs.length - 1) {
					clickActive = false;
				}
			}
		}
		
		protected function clickAction():void {
			
		}
	}
}
