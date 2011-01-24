package  {
	
	public class PannerSpace extends View{
		private var courseList:Vector.<Course>;
		private var reqList:Vector.<String>;
		
		//screen elements
		private var majorPanner:Panner;

		public function PannerSpace(_handler:ViewHandler, _courseList:Vector.<Course>, _reqList:Vector.<String>) {
			super(_handler);
			courseList = _courseList;
			reqList = _reqList;
		}
		
		override public function init() {
			//trace("PannerSpaceStage: " + stage);
			loadView();
		}
		
		override public function tick(currentTime) {
			for each(var element:ScreenElement in screenElements) {
				element.tick();
			}
		}
		
		public function loadView() {
			//trace("LOAD VIEW");
			//trace(courseList);
			majorPanner = new Panner(this, courseList);
			this.addElement(majorPanner, 0,0);
			majorPanner.init();

		}
	}
}
