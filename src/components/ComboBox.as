package components
{
    import flash.display.DisplayObjectContainer;

	/**
	 * 组合框
	 * @author shaotong.zhu
	 * 
	 */	
	public class ComboBox extends Button
	{
        protected var _items:Array;
        protected var _selectedIndex:int;
        protected var _selectedItem:Object;
        
		public function ComboBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, items:Array = null)
		{
            _items = items;
            super(parent, xpos, ypos);
            styleName = 'combobox';
		}
        
        override public function init():void {
            super.init();
        }
        
        override public function render():void {
            super.render();
        }
	}
}