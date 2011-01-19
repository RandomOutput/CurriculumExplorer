package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class ViewHandler extends Sprite 
	{
		public var inputHandler:InputHandler;
		public var dataHandler:DataHandler;
		
		private var startViewURL = "main.xml";
		private var startViewArgs = "Interactive Design And Game Development";
		private var activeView:View;
		private var backStack:Vector.<View>;
		private var currentTime:Number;

		public function ViewHandler(_inputHandler, _dataHandler, _currentTime) {
			inputHandler = _inputHandler;
			dataHandler = _dataHandler;
			currentTime = _currentTime;
			backStack = new Vector.<View>;
		}
		
		public function init() {
			loadView(startViewURL, startViewArgs);
			this.addEventListener(Event.ENTER_FRAME, tick);
		}
		
		public function tick(_currentTime) {
			currentTime = _currentTime
			
			if(activeView) {
				activeView.tick(currentTime);
			}
			
			for(var i:int=0;i<backStack.length;i++) {
				if(backStack[i].markedForDeath = true) {
					this.removeChild(backStack[i]);
					backStack.splice(i,1);
				}
			}
		}
		
		//outro old view, init new view, add oldView to back stack
		public function loadView(viewURL:String, viewArgs:String = "") {
			trace("loadView: " + viewURL);
			
			var delayTime:Number;
			var newView = new View(this, viewURL, viewArgs);
			
			if(activeView != null) {
				backStack.push(activeView);
				delayTime = activeView.outro();
			}
			
			this.addChild(newView);
			newView.init(delayTime, currentTime);
			activeView = newView;
		}
		
		public function kill() {
			//kills
			if(activeView != null) {
				activeView.kill();
				this.removeChild(activeView);
			}
			
			for(var i=0;i<backStack.length;i++) {
				backStack[i].kill();
			}
			
			//null variables
			activeView = null;
			backStack = null;
			currentTime = null;
		}

	}
	
}
