package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class ViewHandler extends Sprite 
	{
		public var inputHandler:InputHandler;
		public var dataHandler:DataHandler;
		
		private var activeView:View;
		private var currentTime:Number;

		public function ViewHandler(_inputHandler, _dataHandler, _currentTime) {
			inputHandler = _inputHandler;
			dataHandler = _dataHandler;
			currentTime = _currentTime;
			this.addEventListener(Event.ENTER_FRAME, checkForDataLoad);
		}
		
		private function checkForDataLoad(e:Event) {
			if(dataHandler.dataLoaded == true) {
				this.removeEventListener(Event.ENTER_FRAME, checkForDataLoad);
				init();
			}
			else {
				return;
			}
		}
		
		public function init() {
			activeView = new PannerSpace(this, dataHandler.getCourses(), dataHandler.getReqs());
			this.addChild(activeView);
			activeView.init();
			this.addEventListener(Event.ENTER_FRAME, tick);
		}
		
		public function tick(_currentTime) {
			currentTime = _currentTime
			
			if(activeView) {
				activeView.tick(currentTime);
			}
		}
		
		public function kill() {
			//kills
			activeView.kill();
			if(this.contains(activeView)) {
				this.removeChild(activeView);
			}
			
			//null variables
			activeView = null;
			currentTime = null;
		}

	}
	
}
