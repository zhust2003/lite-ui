package components
{
	public class RadioGroup extends Group
	{
		public function RadioGroup()
		{
			super();
		}
		
		public function getCheckedValue():* {
			var r:Radio = getCheckedRadio();
            return r.value;
		}
		
		public function getCheckedRadio():Radio {
            var r:Radio;
			for each (var radio:Radio in _list) {
                if (radio.checked) {
                    r = radio;
                    break;
                }
            }
            return r;
		}
		
		public function uncheckAll():void {
            for each (var radio:Radio in _list) {
                radio.checked = false;
            }
		}
	}
}