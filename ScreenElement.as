﻿package  {
	import flash.display.Sprite;
	
	public class ScreenElement extends Sprite{
		protected var handler:View;
		protected var id:String;

		public function ScreenElement(_handler:View, _id:String, _xLoc:int, _yLoc:int) {
			handler = _handler;
			id = _id;
			this.x = _xLoc;
			this.y = _yLoc;
		}
		
		public function init() {
			
		}
		
		public function tick() {
			
		}
		
		public function kill(){
			
		}

	}
	
}
