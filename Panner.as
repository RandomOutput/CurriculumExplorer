package  {
	
	public class Panner extends ScreenElement{
		public var spacing:int = 20;
		public var iconWidth:int = 263.5;
		public var panSpeed:int = 5;
		
		private static var pannerCount:int = 0;
		private var pannerHead:PannerElement;
		private var pannerTail:PannerElement;	
		public var pannerElements:Vector.<PannerElement>;
		private var courseList:Vector.<Course>;
		private var majorList:Vector.<String>; //this is going to become a vector of major objects methinks
		private var lastSpawnedIndex:int;
		private var spawnPassiveElements:Boolean;
		private var thereAreActive:Boolean;

		public function Panner(_handler:View, _courseList:Vector.<Course>) {
			pannerCount++;
			super(_handler, "panner" + pannerCount);
			pannerHead = null;
			pannerTail = null;
			courseList = _courseList;
			pannerElements = new Vector.<PannerElement>;
			majorList = new Vector.<String>;
			spawnPassiveElements = false;
			thereAreActive = false;
		}
		
		override public function init() {
			defineMajorList();
		}
		
		override public function tick() {
			//trace("panner tick");
			thereAreActive = false;
			if(pannerHead != null) {
				pannerHead.moveForward();
			}
			removePastElement();
			spawnNewTail(pannerTail);
			for each(var pannerElement:PannerElement in pannerElements) {
				if(pannerElement.activeElement) {
					handler.setChildIndex(pannerElement, handler.numChildren-1);
					thereAreActive = true;
				}
			}
			
			if(thereAreActive == false) {
				unPassiveAll();
			}
		}
		
		public function removePastElement() {
			for(var j:int=0;j<pannerElements.length;j++) {
				if(pannerElements[j] != pannerHead && pannerElements[j].x > 1280) {
					var oldElement = pannerElements[j];
					if(oldElement.prevElement != null) {
						oldElement.prevElement.nextElement = oldElement.nextElement;
					}
					if(oldElement.nextElement != null) {
						oldElement.nextElement.prevElement = oldElement.prevElement;
					}
					pannerElements.splice(j,1);
					oldElement.kill();
					handler.removeElement(oldElement);
				} else if(pannerElements[j].x > 1280) {
					var oldHead = pannerHead;
					pannerHead = oldHead.prevElement;
					for(var i:int=0;i<pannerElements.length;i++) {
						if(pannerElements[i] == oldHead) {
							pannerElements.splice(i,1);
						}
					}
					oldHead.kill();
					handler.removeElement(oldHead);
				}
			}
		}
		
		public function spawnNewTail(currentTail:PannerElement) {
			if(currentTail == null) {
				return;
			} else if(currentTail.activeElement && (currentTail.nextElement != null)) {
				spawnNewTail(currentTail.nextElement);
				return;
			} else if(currentTail.x > (this.x + spacing)){
				trace("NEW TAIL");
				if(lastSpawnedIndex < majorList.length - 1) {
					lastSpawnedIndex++;
				} else {
					lastSpawnedIndex = 0;
				}
				var newPannerElement:PannerElement = new PannerElement(handler, majorList[lastSpawnedIndex], this, spacing, pannerTail);
				if(spawnPassiveElements) {
					newPannerElement.goPassive();
				}
				pannerTail.prevElement = newPannerElement;
				pannerTail = newPannerElement;
				pannerElements.push(newPannerElement);
				var newX = (newPannerElement.nextElement.x - (spacing + iconWidth));
				handler.addElement(newPannerElement, newX, this.y);
			}
		}
		
		public function recoverAll() {
			for(var i:int=0;i<pannerElements.length;i++) {
				pannerElements[i].recoverContents();
			}
		}
		
		public function passiveAll(except:PannerElement = null) {
			for(var i:int=0;i<pannerElements.length;i++) {
				if(except != null && except != pannerElements[i])
				pannerElements[i].goPassive();
			}
			spawnPassiveElements = true;
		}
		
		public function unPassiveAll() {
			for(var i:int=0;i<pannerElements.length;i++) {
				pannerElements[i].endPassive();
			}
			//spawnPassiveElements = false;
		}
		
		public function defineMajorList(){
			//trace("define major list");
			for each(var course:Course in courseList) {
				if(majorList.length == 0) {
					majorList.push(course.getCrMajor());
				}
				for(var i:int=0;i<majorList.length;i++) {
					if((course.getCrMajor() != majorList[i]) && (i == (majorList.length - 1)) && (course.getCrMajor() != "")) {
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
				trace("major: " + major);
				if(pannerHead == null) {
					newPannerElement = new PannerElement(handler, major, this, spacing);
					if(spawnPassiveElements) {
						newPannerElement.goPassive();
					}
					pannerElements.push(newPannerElement);
					pannerHead = newPannerElement;
					pannerTail = newPannerElement;
					//stage.addChild(newPannerElement);
					handler.addElement(newPannerElement, this.x, this.y);
				} else {
					newPannerElement = new PannerElement(handler, major, this, spacing, pannerTail);
					if(spawnPassiveElements) {
						newPannerElement.goPassive();
					}
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
					handler.addElement(newPannerElement, newX, this.y);
				}
			}
			
			lastSpawnedIndex = majorList.length;
		}
	}
}
