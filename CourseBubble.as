package  {
	
	public class CourseBubble extends ScreenElement{
		private var course:Course;
		private var courseList:Vector.<Course>;

		public function CourseBubble(_handler:ViewHandler, _id:String, _course:Course, _courseList:Vector.<Course>, _xLoc:int = 0, _yLoc:int = 0) {
			trace("gogo bubble");
			super(_handler, _id, _xLoc, _yLoc);
			course = _course;
			courseList = _courseList;
			
			this.titleHeader.text = "" + course.getCrPrefix() + " " + course.getCrNum() + " - " + course.getCrName();
			this.school.text = "" + course.getSchool();
			this.crDescription.text = "" + course.getCrDescription();
			
			var prereqTemp:Vector.<String> = course.getPreReqList();
			trace("prereqTemp: " + prereqTemp);
			for(var i:int=0;i<prereqTemp.length;i++) {
				this.prereqes.text += "" + prereqTemp[i] + " ";
			}
		}
		
		override public function init() {
			
		}
	}
}
