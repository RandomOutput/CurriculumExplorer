package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class View extends Sprite{
		
		protected var dataURL:String;
		protected var viewArgs:String;
		
		public var handler:ViewHandler;
		private var delayTime:int;
		private var currentTime:int;
		private var dataHandler:DataHandler;
		private var screenElements:Vector.<ScreenElement>;
		public var markedForDeath:Boolean;

		public function View(_handler:ViewHandler, _dataURL = "defaultView.xml", _viewArgs:String = "") {
			handler = _handler;
			dataURL = "./xmlData/" + _dataURL;
			viewArgs = _viewArgs;
			screenElements = new Vector.<ScreenElement>;
			markedForDeath = false;
		}
		
		public function init(_delayTime:int, _currentTime:int) {
			delayTime = _delayTime;
			currentTime = _currentTime;
			
			loadViewData();
		}
		
		private function intro() {
			
		}
		
		public function tick(currentTime) {			
			//trace("View: " + dataURL + " - handler: " + this.handler);
			for(var j:int=0;j<this.numChildren;j++){
				if(this.getChildAt(j) is ScreenElement && markedForDeath != true) {
					(this.getChildAt(j) as ScreenElement).tick();
				}
			}
		}
		
		private function loadViewData() {
			var xmlLoader:URLLoader  = new  URLLoader();
			var xmlData:XML = new XML(); 
			
			xmlLoader.addEventListener(Event.COMPLETE, loadData);
 
			xmlLoader.load(new URLRequest(dataURL)); 
		}
		
		private function loadData(e:Event) {
			var newScreenElements:Vector.<ScreenElement> = new Vector.<ScreenElement>;
			var xmlData =  new XML(e.target.data); 
			
			var elementList:XMLList = xmlData.screenElement; 
			for each  (var  screenElement:XML  in elementList)  {				
				var screenElementType:String = screenElement.@type;
				switch(screenElementType) {
					case "BasicButton":
						newScreenElements.push(new BasicButton(this, screenElement.id, screenElement.xLoc, screenElement.yLoc, screenElement.link));
						break;
					case "MajorViewer":
						newScreenElements.push(new MajorViewer(this, screenElement.id, screenElement.xLoc, screenElement.yLoc, viewArgs, screenElement.coursesURL));
						break;
					case "SchoolSelector":
						newScreenElements.push(new SchoolSelector(this, screenElement.id, screenElement.xLoc, screenElement.yloc, screenElement.coursesURL));
						break;
					case "MajorSelector":
						newScreenElements.push(new MajorSelector(this, screenElement.id, screenElement.xLoc, screenElement.yloc, viewArgs, screenElement.coursesURL));
						break;
					case "SchoolIcon":
						newScreenElements.push(new SchoolIcon(this, screenElement.id, viewArgs, screenElement.xLoc, screenElement.yLoc));
						break;
					case "MajorIcon":
						newScreenElements.push(new MajorIcon(this, screenElement.id, viewArgs, screenElement.xLoc, screenElement.yLoc));
						break;
					default:
						trace("ERROR, unknown screenElement type: " + screenElementType);
						break;
				}
			}
			
			//PLACE NEW ELEMENTS
			for(var i=0;i<newScreenElements.length;i++) {
				this.addChild(newScreenElements[i]);
				newScreenElements[i].init();
			}
		}
		
		public function outro():Number {
			this.kill();
			return 0;
		}
		
		public function kill() {
			trace("kill view: " + dataURL);
			dataURL = null;
			
			handler = null;
			delayTime = null;
			currentTime = null;
			dataHandler = null;
			
			for(var i:int=0;i<screenElements.length;i++) {
				screenElements[i].kill();
			}
			
			while(screenElements.length > 0) {
				this.removeChild(screenElements[i]);
			}
			
			screenElements = null;
			markedForDeath = true;
		}

	}
	
}
