package  {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class InputHandler extends Sprite{
		
		private var mouseIsDown:Boolean = false;

		public function InputHandler() {
			this.addEventListener(Event.ADDED_TO_STAGE, initListening);
		}
		
		private function initListening(e:Event) {
			this.removeEventListener(Event.ADDED_TO_STAGE, initListening);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownResponse);
		}
		
		private function mouseDownResponse(e:MouseEvent) {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownResponse);
			mouseIsDown = true;
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpResponse);
		}
		
		private function mouseUpResponse(e:MouseEvent) {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpResponse);
			mouseIsDown = false;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownResponse);
		}
		
		public function getInputs():Vector.<Point> {
			var currentInputs = new Vector.<Point>;
			if(mouseIsDown) {
				currentInputs.push(new Point(stage.mouseX, stage.mouseY));
			}
			return currentInputs;
		}

	}
	
}
