package  {
	
	public class PannerElement extends BasicButton{
		private const MOVE_SPEED:int = 5;
		
		public var myPanner:Panner;
		public var elementData:String;
		public var nextElement:PannerElement;
		public var prevElement:PannerElement;
		private var spacing:int;
		public var activeElement:Boolean;
		public var passive:Boolean;
		private var subElements:Vector.<SubItem>;

		public function PannerElement(_handler:View, _elementData:String, _myPanner:Panner, _spacing, _next:PannerElement = null, _prev:PannerElement = null) {
			trace("panner element created");
			super(_handler, _elementData);
			myPanner = _myPanner;
			spacing = _spacing;
			elementData = _elementData;
			nextElement = _next;
			prevElement = _prev;
			activeElement = false;
			passive = false;
			this.labelText.text = elementData;
			subElements = new Vector.<SubItem>;
			for(var i:int = 0;i<8;i++) {
				subElements.push(new SubItem(handler, "subItem_" + i));
			}
			for(var i:int=0;i<subElements.length;i++) {
				handler.addElement(subElements[i], this.x, this.y);
			}
		}
		
		override public function tick() {
			super.tick();
			handler.setChildIndex(this, handler.numChildren-1);
			if(this.nextElement != null) {
				followElement(this.nextElement);
			}
			for(var i:int=0;i<subElements.length;i++) {
				if(!activeElement) {
					subElements[i].goalX = this.x;
					subElements[i].goalY = this.y;
				}
			}
		}
		
		public function moveForward() {
			if(this.activeElement == true && this.prevElement != null) {
				this.prevElement.moveForward();
			} else {
				this.x += 1;
			}
		}
		
		private function followElement(leader:PannerElement) {
			if(this.activeElement) {
				return;
			} else if(leader == null) {
				return;
			}else if(this == leader) {
				return;
			} else if(leader.activeElement == true) {
				if(leader.nextElement != null) {
					followElement(leader.nextElement);
				} else {
					return;
				}
			} else {
				if(leader.x - this.x > (spacing + this.width)) {
					this.x = leader.x - (spacing + this.width);
				}
			}
		}
		
		override protected function clickAction():void {
			if(this.passive == true) {
				myPanner.recoverAll();
				myPanner.unPassiveAll();
				return;
			}
			if(activeElement == false) {
				trace("parent: " + parent);
				myPanner.recoverAll();
				myPanner.passiveAll(this);
				spillContents();
			} else {
				recoverContents();
			}
		}
		
		private function spillContents() {
			var newX:int;// = this.x + (400 * (i % 3));
			var newY:int;// = this.y + (125 * (Math.floor(i / 3)));
			
			activeElement = true;
			for(var i:int=0;i<subElements.length;i++) {
				newX = handler.x + (250 * (i % 4));
				newY = handler.y + this.height + 10 + (250 * (Math.floor(i / 4)));
				//var newSub:SubItem = new SubItem(handler, "subItem_" + i, newX, newY);
				subElements[i].goalX = newX;
				subElements[i].goalY = newY;
			}
		}
		
		public function recoverContents() {
			activeElement = false;
			for(var i:int=0;i<subElements.length;i++) {
				subElements[i].goalX = this.x;
				subElements[i].goalY = this.y;
			}
		}
		
		public function goPassive() {
			/*this.alpha=.5;
			this.passive = true;*/
		}
		
		public function endPassive() {
			/*this.alpha=1;
			this.passive = false;*/
		}
		
		override public function kill() {
			for(var i:int=0;i<subElements.length;i++) {
				subElements[i].kill();
				handler.removeElement(subElements[i]);
			}
			super.kill();
		}

	}
	
}
