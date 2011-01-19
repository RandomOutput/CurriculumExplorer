package  {
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class InputHandler extends Sprite{

		public function InputHandler() {
			// constructor code
		}
		
		public function getInputs():Vector.<Point> {
			var currentInputs = new Vector.<Point>;
			currentInputs.push(new Point(stage.mouseX, stage.mouseY));
			return currentInputs;
		}

	}
	
}
