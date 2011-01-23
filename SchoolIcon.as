package  {
	
	public class SchoolIcon extends BasicButton{
		private var schoolName:String;
		
		public function SchoolIcon(_handler:View, _id:String, _schoolName:String, _xLoc:int = 0, _yLoc:int = 0) {
			//GOING TO USE A DIFFERENT STRATEGY FOR SWITCHING TO THE MAJOR VIEW
			//convert the name of the school to the link for the school's view page
			//var noSpaceShoolName:String = removeSpaces(_schoolName);
			//var link:String = noSpacesSchoolName + "_reqs.xml";
			
			super(_handler, _id, _xLoc, _yLoc, "-1");
			schoolName = _schoolName;
			this.schoolNameLabel.text = schoolName;
		}
		
		private function removeSpaces(textToClean:String):String {
			var cleanText:String = "";
			
			for(var i:int=0;i<textToClean.length;i++){
				if(textToClean.charAt(i) != " ") {
					cleanText += textToClean.charAt(i);
				}
			}
			trace(cleanText);
			return cleanText;
		}
		
		override protected function clickAction():void {
			//handler.handler.loadView("majorSelectionScreen.xml", schoolName);
		}
	}
}
