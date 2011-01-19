package  {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class MajorSelector extends ScreenElement{
		private var coursesURL;
		private var viewArgs:String;
		private var majors:Vector.<String>;

		public function MajorSelector(_handler:View, _id:String, _xLoc:int, _yLoc:int, _viewArgs, _coursesURL:String) {
			super(_handler, _id, _xLoc, _yLoc);
			viewArgs = _viewArgs;
			coursesURL = _coursesURL;
			majors = new Vector.<String>;
		}
		
		override public function init(){
			super.init();
			loadCourseData();
		}
		
		private function loadCourseData() {
			trace("load course data major");
			var xmlLoader:URLLoader  = new URLLoader();
			var xmlData:XML = new XML(); 
			
			xmlLoader.addEventListener(Event.COMPLETE, handleCourseData);
 
			xmlLoader.load(new URLRequest("./xmlData/" + coursesURL)); 
		}
		
		private function handleCourseData(e:Event) {			
			var xmlData = new XML(e.target.data);
			var courseList:XMLList = xmlData.course; 
			for each  (var course:XML  in courseList)  {				
				if(majors.length == 0 && course.@crMajor != "") {
					majors.push(course.@crMajor);
				}
				
				for(var i=0;i<majors.length;i++) {
					if(majors[i] != course.@crMajor && course.@crMajor != "") {
						if(i == (majors.length -1)) {
							majors.push(course.@crMajor);
						}
					}
					else {
						break;
					}
				}
			}
			
			populateView();
		}
		
		private function populateView() {
			for (var i:int=0;i<majors.length; i++) {
				var newID:String = "" + id + "_" + i;
				var newX:int = 240 * (i % 2);
				var newY:int = 365 * (Math.floor(i / 2));
				var newMajorIcon = new MajorIcon(handler, newID, majors[i], newX, newY); 
				handler.addChild(newMajorIcon);
			}
		}
		
		override public function kill(){
			super.kill();
		}

	}
	
}
