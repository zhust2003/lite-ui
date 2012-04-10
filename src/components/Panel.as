package components
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Rectangle;

	public class Panel extends Component
	{
        private var _background:Bitmap;
        private var _mask:Shape;
        private var _content:Sprite;
        
		public function Panel(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0)
		{
            styleName = 'panel';
			super(parent, xpos, ypos);
		}
        
        override public function init():void {
            super.init();
            
            // 蒙板
            _mask = new Shape();
            super.addChild(_mask);
            
            // 内容
            _content = new Sprite();
            _content.mask = _mask;
            super.addChild(_content);
        }
        
        override public function addChild(child:DisplayObject):DisplayObject {
            _content.addChild(child);
            markForRender();
            return child;
        }		
        
        public function addRawChild(child:DisplayObject):DisplayObject
        {
            super.addChild(child);
            return child;
        }
        
        public function get content():Sprite {
            return _content;
        }
        
        override public function render():void {
            super.render();
            
            _mask.graphics.clear();
            _mask.graphics.beginFill(0xff0000);
            _mask.graphics.drawRect(0, 0, width, height);
            _mask.graphics.endFill();
        }
	}
}