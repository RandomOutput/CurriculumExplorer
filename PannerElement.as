package  {
	
	public class PannerElement extends BasicButton{
		private const MOVE_SPEED:int = 5;
		private var followSpeed:int = 10;
		
		public var myPanner:Panner;
		public var elementData:String;
		public var nextElement:PannerElement;
		public var prevElement:PannerElement;
		private var spacing:int;
		public var activeElement:Boolean;
		public var returningElement:Boolean;
		public var passive:Boolean;
		private var subElements:Vector.<SubItem>;

		public function PannerElement(_handler:View, _elementData:String, _myPanner:Panner, _spacing, _next:PannerElement = null, _prev:PannerElement = null) {
			//trace("panner element created");
			super(_handler, _elementData);
			myPanner = _myPanner;
			spacing = _spacing;
			elementData = _elementData;
			nextElement = _next;
			prevElement = _prev;
			activeElement = false;
			returningElement = false;
			passive = false;
			this.labelText.text = elementData;
			subElements = new Vector.<SubItem>;
			var generalDescription:String = "Major Description Placeholder";
			var professorInterview:String= "Professor Interview Placeholder";
			var generalDescriptionElement:textAreaSubItem = new textAreaSubItem(handler, "subItem_desc", 0,0, generalDescription); 
			var professorInterviewElement:textAreaSubItem = new textAreaSubItem(handler, "subItem_desc", 0,0, professorInterview);
			subElements.push(generalDescriptionElement);
			subElements.push(professorInterviewElement);
			for(var i:int = 0;i<6;i++) {
				subElements.push(new SubItem(handler, "subItem_" + i));
			}
			for(var i:int=0;i<subElements.length;i++) {
				handler.addElement(subElements[i], this.x, this.y);
			}
		}
		
		override public function tick() {
			//trace("PannerElement [" + this.id + "]: " + this.activeElement);
			super.tick();
			
			if(this.activeElement) {
				this.returningElement = false;
			}
			
			if(this.activeElement || this.returningElement) {
				handler.setChildIndex(this, handler.numChildren-1);
			}
			
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
			if((this.activeElement == true) && this.prevElement != null) {
				//trace("PannerElement [" + this.id + "] Active = " + this.activeElement + ", returning = " + this.returningElement + ": passing to next Element");
				this.prevElement.moveForward();
				return;
			} else if (this.activeElement != true){
				//trace("PannerElement [" + this.id + "]: head is not active and is moveing forward");
				if(this.returningElement == true && this.prevElement != null) {
					if(this.prevElement.x + spacing + this.prevElement.width >= this.x) {
						if(this.prevElement.x + spacing + this.prevElement.width >= this.x + followSpeed) {
							this.x += followSpeed;
						} else  {
							this.x = this.prevElement.x + spacing + this.prevElement.width;
							returningElement = false;
						}
					}
					
					if(this.prevElement.x + spacing + this.prevElement.width <= this.x) 
					{
						returningElement = false;
					}
				} 
				else if(this.returningElement == false)
				{
					var anyActive:Boolean = false;
					for(var q:int=0;q<myPanner.pannerElements.length;q++) {
						if(myPanner.pannerElements[q].returningElement == true) {
							anyActive = true;
						}
					}
					
					if(anyActive == true) {
						//this.x += followSpeed;
						this.x += 1;
					} else {
						this.x += 1;
					}
				}
			}
		}
		
		private function followElement(leader:PannerElement) {
			//trace("PannerElement.followElement [" + this.id + "]: Is in followElement**********, returning: + " + this.returningElement);
			//trace("PannerElement.followElement [" + this.id + "] leader=" + leader.id + ": " + leader.activeElement);
			if(this.activeElement) {
				//trace("PannerElement.followElement [" + this.id + "]: Is an activeElement");
				return;
			} else if(leader == null) {
				//trace("PannerElement.followElement [" + this.id + "]: has no leader");
				return;
			}else if(this == leader) {
				//trace("PannerElement.followElement [" + this.id + "]: is the leader");
				return;
			} else if(leader.activeElement == true) {
				//trace("PannerElement.followElement [" + this.id + "]: the leader is an active element.");
				if(leader.nextElement != null) {
					followElement(leader.nextElement);
				} else {
					return;
				}
			} else {
				//trace("103 PannerElement.followElement [" + this.id + "]: attempting to follow.");
				if(leader.x - this.x > (spacing + this.width)) {
					//trace("105 PannerElement.followElement [" + this.id + "]: spacing is too great.");
					//trace("106 PannerElement.followElement [" + this.id + "] returningElement: " + this.returningElement);
					if(this.returningElement == true) {
						//trace("108 PannerElement.followElement [" + this.id + "] returningElementPOST: " + this.returningElement);
						//trace("109 PannerElement.followElement [" + this.id + "]: is a returning element.");
						if(leader.x - (this.x + this.followSpeed) > spacing + this.width) {
							this.x += followSpeed;
						}
						else {
							this.x = leader.x - spacing - this.width;
							returningElement = false;
						}
						
						if(leader.x - this.x <= (spacing + this.width)) {
							returningElement = false;
						}
					}
					else {
						this.x = leader.x - (spacing + this.width);
					}
				}
			}
		}
		
		override protected function clickAction():void {
			if(this.passive == true) {
				//myPanner.recoverAll();
				myPanner.unPassiveAll();
				return;
			}
			//trace("elementClick");
			if(activeElement == false) {
				//trace("parent: " + parent);
				myPanner.recoverAll();
				myPanner.passiveAll(this);
				spillContents();
			} else {
				//trace("attempting to recover");
				recoverContents();
			}
		}
		
		private function spillContents() {
			var newX:int;
			var newY:int;
			
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
			returningElement = true;
			for(var i:int=0;i<subElements.length;i++) {
				subElements[i].goalX = this.x;
				subElements[i].goalY = this.y;
			}
		}
		
		public function goPassive() {
			this.alpha=.5;
			this.passive = true;
		}
		
		public function endPassive() {
			this.alpha=1;
			this.passive = false;
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
