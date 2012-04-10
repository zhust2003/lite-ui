package components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class Radio extends Button
	{
		private var _group:RadioGroup;
        private var _value:Object;
		
		public function Radio(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, group:RadioGroup = null, label:String = "", value:Object = null, _checked:Boolean = false)
		{
			super(parent, xpos, ypos, label, onClick);
            styleName = 'radio';
			_checked = _checked;
            _value = value;
			_group = group;
			_group.add(this);
            
		}
		
		protected function onClick(event:MouseEvent):void
		{
            group.uncheckAll();
			checked = true;
		}
		
		override public function render():void {
			super.render();
            
            // 对齐标签位置
            _label.x = (background.width) + 2;
		}
		
		
		public function get group():RadioGroup
		{
			return _group;
		}
		
		public function set group(g:RadioGroup):void
		{
			_group = g;
		}
        
        public function get value():Object {
            return _value;
        }
	}
}