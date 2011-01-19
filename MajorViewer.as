package  {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class MajorViewer extends ScreenElement{
		private var viewArgs:String;
		private var coursesURL;
		private var majorRequirements:Vector.<String>;
		private var coursesForView:Vector.<Course>;
		private var courses:Vector.<Course>;
		private var electives:Vector.<Course>;

		public function MajorViewer(_handler:ViewHandler, _id:String, _xLoc:int, _yLoc:int, _viewArgs:String, _coursesURL:String) {
			super(_handler, _id, _xLoc, _yLoc);
			viewArgs = _viewArgs;
			coursesURL = _coursesURL;
			coursesForView = new Vector.<Course>;
			courses = new Vector.<Course>;
			electives = new Vector.<Course>;
		}
		
		override public function init(){
			super.init();
			loadCourseData();
			loadMajorData();
		}
		
		private function loadMajorData() {
			var xmlLoader:URLLoader  = new  URLLoader();
			var xmlData:XML = new XML(); 
			
			xmlLoader.addEventListener(Event.COMPLETE, handleMajorData);
 
			xmlLoader.load(new URLRequest("./xmlData/" + "majorReqs.xml")); 
		}
		
		private function handleMajorData(e:Event) {
			var xmlData = new XML(e.target.data); 
			var courseList:XMLList = xmlData.major.(@majorName = viewArgs).courseReq; 
			var electList:XMLList = xmlData.major.(@majorName = viewArgs).electReq;

			for each  (var  requirement:XML  in courseList)  {				
				for(var i=0;i<courses.length;i++) {
					if((courses[i].getCrPrefix() == requirement.@crPrefix) && (courses[i].getCrNum() == requirement.@crNumber)) {
						coursesForView.push(courses[i]);
					}
				}
			}
			
			for each (var elect:XML in electList) {
				
			}
			
			populateView();
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
				var testList:Vector.<String> = new Vector.<String>;
				var imageURLList:Vector.<String> = new Vector.<String>;
				var preReqList:Vector.<String> = new Vector.<String>; 
				
				var testimonlialList:XMLList = course.testimonial;
				var imageList:XMLList = course.image;
				var prereqXML:XMLList = course.prereq;
				for each(var testimonial:String in testimonlialList){
					testList.push(testimonial);
				}
				for each(var imageURL:String in imageList){
					imageURLList.push(imageURL);
				}
				for each(var thisPrereq:String in prereqXML){
					//trace(course.@crNum + " adds prereq: " + thisPrereq);
					preReqList.push(thisPrereq);
				}
				
				courses.push(new Course(course.@crNum, course.@crName, course.@crPrefix, course.@crSchool, course.crDescription, testList, imageURLList, preReqList));
			}
		}
		
		private function populateView() {
			for (var i:int=0;i<coursesForView.length; i++) {
				var newID:String = "" + id + "_" + i;
				var newX:int = 400 * (i % 2);
				var newY:int = 400 * (Math.floor(i / 2));
				trace("-----");
				trace("i: " + i);
				trace("i/2 floored: " + Math.floor(i/2));
				trace("i % 2" + (i % 2));
				trace("newX: " + newX);
				trace("newY: " + newY);
				trace("-----");
				var newBubble = new CourseBubble(handler, newID, coursesForView[i], courses, newX, newY); 
				handler.addChild(newBubble);
			}
		}
		
		override public function kill(){
			super.kill();
		}

	}
	
}
