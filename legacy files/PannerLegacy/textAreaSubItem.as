package  {
	
	public class textAreaSubItem extends SubItem{

		public function textAreaSubItem(_handler:View, _id:String, _goalX:int = 0, _goalY:int = 0, _textData:String = "") {
			super(_handler, _id, _goalX, _goalY);
			this.textArea.text = _textData;
			// constructor code
		}

	}
	
}
