package  {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class CourseViewer extends ScreenElement{
		private var viewArgs:String;
		private var coursesURL;
		private var majorRequirements:Vector.<String>;
		private var course:Course;
		private var courses:Vector.<Course>;
		private var electives:Vector.<Course>;

		public function CourseViewer(_handler:View, _id:String, _xLoc:int, _yLoc:int, _viewArgs:String, _coursesURL:String) {
			super(_handler, _id, _xLoc, _yLoc);
			viewArgs = _viewArgs;
			coursesURL = _coursesURL;
			courses = new Vector.<Course>;
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
			
			for each  (var courseData:XML  in courseList)  {				
				var courseID:String = "" + courseData.@crPrefix + courseData.@crNum;
				
				if(courseID == viewArgs) {
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
					
					course = new Course(courseData.@crNum, courseData.@crName, courseData.@crMajor, courseData.@crPrefix, courseData.@crSchool, courseData.crDescription, testList, imageURLList, preReqList);
					
					break;
				}
			}
			
			fillView();
		}
		
		private function fillView() {
			this.titleHeader.text = "" + course.getCrPrefix() + " " + course.getCrNum() + " - " + course.getCrName();
			this.school.text = "" + course.getSchool();
			this.major.text = "" + course.getCrMajor();
			this.crDescription.text = "" + course.getCrDescription();
			
			var prereqTemp:Vector.<String> = course.getPreReqList();
			trace("prereqTemp: " + prereqTemp);
			for(var i:int=0;i<prereqTemp.length;i++) {
				this.prereqes.text += "" + prereqTemp[i] + " ";
			}
		}
		
		override public function kill(){
			super.kill();
		}

	}
	
}
