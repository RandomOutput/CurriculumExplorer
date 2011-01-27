package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class View extends MovieClip {
		
		public var handler:ViewHandler;
		public var screenElements:Vector.<ScreenElement>;
		public var markedForDeath:Boolean;
		

		public function View(_handler:ViewHandler) {
			handler = _handler;
			screenElements = new Vector.<ScreenElement>;
			markedForDeath = false;
			//this.visible = false;
		}
		
		public function init() {
			//this.visible = true;
			loadView();
		}
		
		public function tick(currentTime) {			
			for(var j:int=0;j<this.numChildren;j++){
				//unless this view is marked for death, run the tick of every screen element
				if(this.getChildAt(j) is ScreenElement && markedForDeath != true) {
					(this.getChildAt(j) as ScreenElement).tick();
				}
			}
		}
		
		private function loadView() {
			this.visible = true;
		}
		
		public function kill() {
			handler = null;
			
			//kill all screen elements
			for(var i:int=0;i<screenElements.length;i++) {
				screenElements[i].kill();
			}
			
			//remove all screen elements
			while(screenElements.length > 0) {
				this.removeChild(screenElements[i]);
			}
			
			screenElements = null;
			markedForDeath = true;
		}
		
		public function addElement(newElement:ScreenElement, elementX:int, elementY:int) {
			screenElements.push(newElement);
			newElement.x = elementX;
			newElement.y = elementY;
			this.addChild(newElement);
			//trace("addElementStage: " + stage);
		}
		
		public function removeElement(element:ScreenElement) {
			for(var i:int=0;i<screenElements.length;i++){
				if(element == screenElements[i]) {
					screenElements[i].kill();
					if(this.contains(screenElements[i])) {
						this.removeChild(screenElements[i]);
						trace("removedElement: " + screenElements[i].id);
					}
					else {
						trace("DOES NOT CONTAIN SCREENELEMENTS[i]: " + screenElements[i].id);
						trace("ScreenElements[i] parent: " + screenElements[i].parent);
						//screenElements[i].parent.removeChild(screenElements[i]);
					}
					screenElements.splice(i, 1);
					return;
				}
			}
			trace("ERROR: Element not found in: " + element);
		}

	}
	
}
