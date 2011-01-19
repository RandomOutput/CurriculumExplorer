package  {
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	
	public class CurriculumExplorer extends MovieClip{
		private var viewHandler:ViewHandler;
		private var inputHandler:InputHandler;
		private var dataHandler:DataHandler;

		private var currentTime:Number;
		private var startTime:Number;
		
		public function CurriculumExplorer() {
			init();
		}
		
		public function init() {
			inputHandler = new InputHandler();
			dataHandler = new DataHandler();
			viewHandler = new ViewHandler(inputHandler, dataHandler, currentTime);
			
			stage.addChild(inputHandler);
			stage.addChild(viewHandler);
			
			viewHandler.init();
			
			this.addEventListener(Event.ENTER_FRAME, tick);
		}
		
		private function tick(event:Event) {
			currentTime = getTimer();
			
			//inputHandler.tick(currentTime);
			viewHandler.tick(currentTime);
		}
		
		public function reset() {
			//remove stage objects
			stage.removeChild(viewHandler);
			
			//kill handlers
			viewHandler.kill();
			//inputHandler.kill();
			//dataHandler.kill();
			
			//null functions
			viewHandler = null;
			inputHandler = null;
			dataHandler = null;
			
			currentTime = null;
			startTime = null;
		}

	}
	
}
