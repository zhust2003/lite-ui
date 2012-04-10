package layouts
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;
    
    import layouts.aligns.*
    
    public class Layout extends Sprite
    {
        private var _width:Number;
        private var _height:Number;
        protected var _contentWidth:Number;
        protected var _contentHeight:Number;
        
        private var _padding:Padding = new Padding(0, 0, 0, 0);
        private var _margin:Margin = new Margin(0, 0, 0, 0);
        
        public function Layout()
        {
        }
        
        public function set padding(p:Padding):void {
            _padding.left = p.left;
            _padding.right = p.right;
            _padding.top = p.top;
            _padding.bottom = p.bottom;
            invalidateLayout();
        }
        
        public function get padding():Padding {
            return _padding;
        }
        
        public function set margin(m:Margin):void {
            _margin.left = m.left;
            _margin.right = m.right;
            _margin.top = m.top;
            _margin.bottom = m.bottom;
        }
        
        public function get margin():Margin {
            return _margin;
        }
        
        override public function get width():Number {
            if(! isNaN(_width))
            {
                return _width;
            }
            return _contentWidth;
        }
        
        override public function set width(w:Number):void {
            if (_width != w) {
                _width = w;
                invalidateLayout();
            }
        }
        
        override public function get height():Number {
            if(! isNaN(_height))
            {
                return _height;
            }
            return _contentHeight;
        }
        
        override public function set height(h:Number):void {
            if (_height != h) {
                _height = h;
                invalidateLayout();
            }
        }
        
        override public function addChild(child:DisplayObject):DisplayObject {
            child = super.addChild(child);
            invalidateLayout();
            return child;
        }
        
        override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
            child = super.addChildAt(child, index);
            invalidateLayout();
            return child;
        }
        
        override public function removeChildAt(index:int):DisplayObject
        {
            var child:DisplayObject = super.removeChildAt(index);
            invalidateLayout();
            return child;
        }
        
        override public function removeChild(child:DisplayObject):DisplayObject {
            child = super.removeChild(child);
            invalidateLayout();
            return child;
        }
        
        public function invalidateLayout():void {
            addEventListener(Event.ENTER_FRAME, _render);
        }
        
        private function _render(event:Event):void
        {
            removeEventListener(Event.ENTER_FRAME, _render);
            render();
        }
        
        protected function render():void
        {
            var children:Array = [];
            var childCount:int = this.numChildren;
            for(var i:int = 0; i < childCount; i++)
            {
                children.push(this.getChildAt(i));
            }
            layout(children);
            
            // 得到子元素边界
            var bounds:Rectangle = Layout.getBounds(children);
            
            // 设置内容宽高
            _contentWidth = bounds.x + bounds.width + padding.left + padding.right;
            _contentHeight = bounds.y + bounds.height + padding.top + padding.bottom;
        }
        
        protected function layout(children:Array):void {
            
        }
        
        
        public static function align(target:DisplayObject, bounds:Rectangle, horizontalAlign:String = null, verticalAlign:String = null):void
        {	
            var horizontalDifference:Number = bounds.width - target.width;
            switch(horizontalAlign)
            {
                case HorizontalAlignment.LEFT:
                    target.x = bounds.x;
                    break;
                case HorizontalAlignment.CENTER:
                    target.x = bounds.x + (horizontalDifference) / 2;
                    break;
                case HorizontalAlignment.RIGHT:
                    target.x = bounds.x + horizontalDifference;
                    break;
            }
            
            var verticalDifference:Number = bounds.height - target.height;
            switch(verticalAlign)
            {
                case VerticalAlignment.TOP:
                    target.y = bounds.y;
                    break;
                case VerticalAlignment.MIDDLE:
                    target.y = bounds.y + (verticalDifference) / 2;
                    break;
                case VerticalAlignment.BOTTOM:
                    target.y = bounds.y + verticalDifference;
                    break;
            }
        }
        
        public static function getBounds(children:Array):Rectangle {
            var minX:Number = 0;
            var maxX:Number = 0;
            var minY:Number = 0;
            var maxY:Number = 0;
            var childCount:int = children.length;
            for(var i:int = 0; i < childCount; i++)
            {
                var child:DisplayObject = children[i];
                var childMaxX:Number = child.x + child.width;
                var childMaxY:Number = child.y + child.height;
                minX = Math.min(minX, child.x);
                minY = Math.min(minY, child.y);
                maxX = Math.max(maxX, childMaxX);
                maxY = Math.max(maxY, childMaxY);
            }
            
            return new Rectangle(minX, minY, maxX - minX, maxY - minY);
        }
    }
}