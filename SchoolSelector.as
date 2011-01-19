package  {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class SchoolSelector extends ScreenElement{
		private var coursesURL;
		private var schools:Vector.<String>;

		public function SchoolSelector(_handler:View, _id:String, _xLoc:int, _yLoc:int, _coursesURL:String) {
			super(_handler, _id, _xLoc, _yLoc);
			coursesURL = _coursesURL;
			schools = new Vector.<String>;
		}
		
		override public function init(){
			super.init();
			loadCourseData();
		}
		
		private function loadCourseData() {
			var xmlLoader:URLLoader  = new URLLoader();
			var xmlData:XML = new XML(); 
			
			xmlLoader.addEventListener(Event.COMPLETE, handleCourseData);
 
			xmlLoader.load(new URLRequest("./xmlData/" + coursesURL)); 
		}
		
		private function handleCourseData(e:Event) {			
			var xmlData = new XML(e.target.data);
			var courseList:XMLList = xmlData.course; 
			
			for each  (var course:XML  in courseList)  {				
				if(schools.length == 0) {
					schools.push(course.@crSchool);
				} else {
					
					for(var i=0;i<schools.length;i++) {
						if(schools[i] != course.@crSchool) {
							if(i == (schools.length -1)) {
								schools.push(course.@crSchool);
							}
						}
						else {
							break;
						}
					}
				}
			}
			
			populateView();
		}
		
		private function populateView() {
			for (var i:int=0;i<schools.length; i++) {
				var newID:String = "" + id + "_" + i;
				var newX:int = 240 * (i % 2);
				var newY:int = 365 * (Math.floor(i / 2));
				var newSchoolIcon = new SchoolIcon(handler, newID, schools[i], newX, newY); 
				handler.addChild(newSchoolIcon);
			}
		}
		
		override public function kill(){
			super.kill();
		}

	}
	
}
