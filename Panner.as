package  {
	
	public class Panner extends ScreenElement{
		public var spacing:int = 20;
		public var iconWidth:int = 263.5;
		public var panSpeed:int = 5;
		
		private static var pannerCount:int = 0;
		private var pannerHead:PannerElement;
		private var pannerTail:PannerElement;	
		private var pannerElements:Vector.<PannerElement>;
		private var courseList:Vector.<Course>;
		private var majorList:Vector.<String>; //this is going to become a vector of major objects methinks
		private var lastSpawnedIndex:int;

		public function Panner(_handler:View, _courseList:Vector.<Course>) {
			pannerCount++;
			super(_handler, "panner" + pannerCount);
			pannerHead = null;
			pannerTail = null;
			courseList = _courseList;
			pannerElements = new Vector.<PannerElement>;
			majorList = new Vector.<String>;
			
		}
		
		override public function init() {
			defineMajorList();
		}
		
		override public function tick() {
			//trace("panner tick");
			if(pannerHead != null) {
				pannerHead.moveForward();
			}
			removePastHead();
			spawnNewTail();
			/*for each(var pannerElement:PannerElement in pannerElements) {
				pannerElement.tick();
			}*/
		}
		
		public function removePastHead() {
			
		}
		
		public function spawnNewTail() {
			
		}
		
		public function defineMajorList(){
			//trace("define major list");
			for each(var course:Course in courseList) {
				if(majorList.length == 0) {
					majorList.push(course.getCrMajor());
				}
				for(var i:int=0;i<majorList.length;i++) {
					if((course.getCrMajor() != majorList[i]) && (i == (majorList.length - 1))) {
						majorList.push(course.getCrMajor());
					}
				}
			}
			spawnPannerElements();
		}
		
		private function spawnPannerElements() {
			//trace("spawn panner elements");
			//trace(courseList);
			var newPannerElement:PannerElement;
			
			for each(var major:String in majorList) {
				
				if(pannerHead == null) {
					newPannerElement = new PannerElement(handler, major, spacing);
					pannerElements.push(newPannerElement);
					pannerHead = newPannerElement;
					pannerTail = newPannerElement;
					trace("newPannerElement: " + newPannerElement);
					//stage.addChild(newPannerElement);
					handler.addElement(newPannerElement, this.x, this.y);
				} else {
					newPannerElement = new PannerElement(handler, major, spacing, pannerTail);
					pannerTail.prevElement = newPannerElement;
					pannerTail = newPannerElement;
					pannerElements.push(newPannerElement);
					/*trace("handler: " + handler);
					trace("newPannerElement: " + newPannerElement);
					trace("newPannerElement.prevElement: " + newPannerElement.prevElement);
					trace("newPannerElement.nextElement: " + newPannerElement.nextElement);
					trace("spacing: " + spacing);
					trace("iconWidth: " + iconWidth);*/
					var newX = (newPannerElement.nextElement.x - (spacing + iconWidth));
					trace(newX);
					handler.addElement(newPannerElement, newX, this.y);
				}
			}
			
			lastSpawnedIndex = majorList.length;
		}
	}
}
