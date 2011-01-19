package  {
	
	public class MajorIcon extends BasicButton{
		private var majorName:String;
		
		public function MajorIcon(_handler:View, _id:String, _majorName:String, _xLoc:int = 0, _yLoc:int = 0) {
			super(_handler, _id, _xLoc, _yLoc, "-1");
			majorName = _majorName;
			this.majorNameLabel.text = majorName;
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
			handler.handler.loadView("majorViewerScreen.xml", majorName);
		}
	}
}
