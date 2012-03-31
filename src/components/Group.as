package components
{
	public class Group
	{
		protected var _list:Vector.<Component> = new Vector.<Component>();
		public function Group()
		{
		}
		
		public function add(c:Component):void {
			_list.push(c);
		}
		
		public function remove(c:Component):void {
			var index:int = _list.indexOf(c);
			if (index > -1)
			{
				_list.splice(index, 1);
			}
		}
		
		public function get list():Vector.<Component> {
			return _list;
		}
	}
}