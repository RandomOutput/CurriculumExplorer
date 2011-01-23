package  {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class DataHandler {
		private var coursesURL = "courses.xml";
		private var courses:Vector.<Course>;
		private var requirements:Vector.<String>;
		public var dataLoaded:Boolean = false;

		public function DataHandler() {
			courses = new Vector.<Course>;
			requirements = new Vector.<String>;
			loadCourseData();
			//loadReqData();
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
			
			for each  (var courseData:XML  in courseList)  {				
				var testList:Vector.<String> = new Vector.<String>;
				var imageURLList:Vector.<String> = new Vector.<String>;
				var preReqList:Vector.<String> = new Vector.<String>; 
				
				var testimonlialList:XMLList = courseData.testimonial;
				var imageList:XMLList = courseData.image;
				var prereqXML:XMLList = courseData.prereq;
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
				
				courses.push(new Course(courseData.@crNum, courseData.@crName, courseData.@crMajor, courseData.@crPrefix, courseData.@crSchool, courseData.crDescription, testList, imageURLList, preReqList));
			}
			
			dataLoaded = true;
		}
		
		public function getCourses():Vector.<Course> {
			trace("DATA HANDLER");
			trace(courses);
			return courses;
		}
		
		public function getReqs():Vector.<String> {
			return requirements;
		}

	}
	
}
