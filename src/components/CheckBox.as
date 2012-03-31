package components
{
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;

	public class CheckBox extends Button
	{
	    private var _value:Object;
        
		public function CheckBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, label:String = "", value:Object = null, _checked:Boolean = false)
		{
            super(parent, xpos, ypos, label, onClick);
            styleName = 'checkBox';
            checked = _checked;
            _value = value;
		}
        
        protected function onClick(event:MouseEvent):void
        {
            checked = !checked;
        }
        
        override public function render():void {
            super.render();
            
            // 对齐标签位置
            _label.x = (background.width) + 2;
        }
        
        public function get value():Object {
            return _value;
        }
        
        public function set value(v:Object):void {
            _value = v;
        }
	}
}