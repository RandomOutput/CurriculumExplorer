package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class View extends Sprite{
		
		protected var dataURL:String;
		protected var viewArgs:String;
		
		private var handler:ViewHandler;
		private var delayTime:int;
		private var currentTime:int;
		private var dataHandler:DataHandler;
		private var screenElements:Vector.<ScreenElement>;
		public var markedForDeath:Boolean;

		public function View(_dataURL = "defaultView.xml", _viewArgs:String = "") {
			dataURL = "./xmlData/" + _dataURL;
			viewArgs = _viewArgs;
			screenElements = new Vector.<ScreenElement>;
			markedForDeath = false;
		}
		
		public function init(_handler:ViewHandler, _delayTime:int, _currentTime:int) {
			handler = _handler;
			delayTime = _delayTime;
			currentTime = _currentTime;
			
			loadViewData();
		}
		
		private function intro() {
			
		}
		
		public function tick(currentTime) {
			for(var i:int=0;i<this.numChildren;i++){
				(this.getChildAt(i) as ScreenElement).tick();
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
						newScreenElements.push(new BasicButton(handler, screenElement.id, screenElement.xLoc, screenElement.yLoc, screenElement.link));
						break;
					case "MajorViewer":
						newScreenElements.push(new MajorViewer(handler, screenElement.id, screenElement.xLoc, screenElement.yLoc, viewArgs, screenElement.coursesURL));
						break;
					case "SchoolSelector":
						newScreenElements.push(new SchoolSelector(handler, screenElement.id, screenElement.xLoc, screenElement.yloc, screenElement.coursesURL));
						break;
					case "MajorSelector":
						newScreenElements.push(new MajorSelector(handler, screenElement.id, screenElement.xLoc, screenElement.yloc, viewArgs, screenElement.coursesURL));
						break;
					case "SchoolIcon":
						newScreenElements.push(new SchoolIcon(handler, screenElement.id, viewArgs, screenElement.xLoc, screenElement.yLoc));
						break;
					case "MajorIcon":
						newScreenElements.push(new MajorIcon(handler, screenElement.id, viewArgs, screenElement.xLoc, screenElement.yLoc));
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
			trace("kill");
			dataURL = null;
			
			handler = null;
			delayTime = null;
			currentTime = null;
			dataHandler = null;
			
			for(var i:int=0;i<screenElements.length;i++) {
				screenElements[i].kill();
				//this.removeChild(screenElements[i]);
			}
			
			screenElements = null;
			markedForDeath = true;
		}

	}
	
}
