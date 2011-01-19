package  {
	
	public class Course{
		private var crNum:int;
		private var crName:String;
		private var crMajor:String;
		private var crPrefix:String;
		private var crSchool:String;
		private var crDescription:String;
		private var testList:Vector.<String>;
		private var imageURLList:Vector.<String>;
		private var preReqList:Vector.<String>;

		public function Course(_crNum, _crName, _crMajor, _crPrefix, _crSchool, _crDescription, _testList, _imageURLList, _preReqList) {
			crNum = _crNum;
			crName = _crName;
			crMajor = _crMajor;
			crPrefix = _crPrefix;
			crSchool = _crSchool;
			crDescription = _crDescription;
			testList = _testList;
			imageURLList = _imageURLList;
			preReqList = _preReqList;
		}
		
		public function getCrNum():int {
			return crNum;
		}
		
		public function getCrName():String {
			return crName;
		}
		
		public function getCrMajor():String {
			return crMajor;
		}
		
		public function getCrPrefix():String {
			return crPrefix;
		}
		
		public function getSchool():String {
			return crSchool;
		}
		
		public function getCrDescription():String {
			return crDescription;
		}
		
		public function getTestList():Vector.<String> {
			return testList;
		}
		
		public function getImageURLList():Vector.<String> {
			return imageURLList;
		}
		
		public function getPreReqList():Vector.<String> {
			return preReqList;
		}

	}
	
}
