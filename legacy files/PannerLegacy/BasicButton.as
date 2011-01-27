package  {
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class BasicButton extends ScreenElement{
		private const HOLD_TIME:int = 0;
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
			if(inputs.length == 0) {
				clickActive = false;
			}
			for (var i:int=0;i<inputs.length;i++){
				if(this.hitTestPoint(inputs[i].x, inputs[i].y) && ((getTimer() - startTime >= HOLD_TIME))) {
					for(var j:int=0; j<handler.screenElements.length;j++) {
						if(handler.screenElements[j].hitTestPoint(inputs[i].x, inputs[i].y)) {
							//trace("attempt 1: " + handler.handler.getChildIndex(handler.screenElements[j]));
							//trace("attempt 2: " + handler.handler.getChildIndex(this));
							if(handler.getChildIndex(handler.screenElements[j]) > handler.getChildIndex(this)) {
							   return;
							}
						}
					}
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
