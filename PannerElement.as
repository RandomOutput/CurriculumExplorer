package  {
	
	public class PannerElement extends ScreenElement{
		private const MOVE_SPEED:int = 5;
		
		public var elementData:String;
		public var nextElement:PannerElement;
		public var prevElement:PannerElement;
		private var spacing:int;
		public var active:Boolean;

		public function PannerElement(_handler:View, _elementData:String, _spacing, _next:PannerElement = null, _prev:PannerElement = null) {
			trace("panner element created");
			super(_handler, _elementData);
			spacing = _spacing;
			elementData = _elementData;
			nextElement = _next;
			prevElement = _prev;
		}
		
		override public function tick() {
			if(this.nextElement != null) {
				followElement(this.nextElement);
			}
		}
		
		public function moveForward() {
			this.x += 1;
		}
		
		private function followElement(leader:PannerElement) {
			if(this == leader) {
				return;
			} else if(leader.active == true) {
				if(this.nextElement != null) {
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

	}
	
}
