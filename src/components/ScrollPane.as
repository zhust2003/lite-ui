package components
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    
    public class ScrollPane extends Panel
    {
        protected var _vScrollBar:VScrollBar;
        protected var _hScrollBar:HScrollBar;
        
        
        public function ScrollPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
        {
            super(parent, xpos, ypos);
        }
        
        override public function init():void {
            super.init();
            setSize(200, 200);
            style.backgroundSize[0] = width;
            style.backgroundSize[1] = height;
            
            
            _vScrollBar = new VScrollBar(null, width - 16, 0); 
            _hScrollBar = new HScrollBar(null, 0, height - 16);
            addRawChild(_vScrollBar);
            addRawChild(_hScrollBar);
            
            _vScrollBar.addEventListener(Event.CHANGE, onScrollbarScroll);
            _hScrollBar.addEventListener(Event.CHANGE, onScrollbarScroll);
            addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
        }
        
        protected function onMouseWheel(event:MouseEvent):void
        {
            _vScrollBar.value -= event.delta * 5;
            markForRender();
        }
        
        protected function onScrollbarScroll(event:Event):void
        {
            content.x = -_hScrollBar.value;
            content.y = -_vScrollBar.value;
        }
        
        override public function render():void {
            super.render();
            
            var maxHeight:Number = content.height;
            var maxWidth:Number = content.width;
            
            // 因为flash的计算高度机制，因为content是容器，高度计算的是所有子元素的边缘，所以可能跟设想的高度不一样
            // 这重新加上所有元素中，最边缘的坐标，加上及所需的高度
            if (content.numChildren > 0) {
                var minX:uint = uint.MAX_VALUE;
                var minY:uint = uint.MAX_VALUE;
                for (var i:uint = 0; i < content.numChildren; ++i) {
                    var nowChild:DisplayObject = content.getChildAt(i);
                    minX = Math.min(minX, nowChild.x);
                    minY = Math.min(minY, nowChild.y);
                }
                maxHeight += minY;
                maxWidth += minX;
            }
            
            var vPercent:Number = height / maxHeight;
            var hPercent:Number = width / maxWidth;
            
            _vScrollBar.x = width - 16;
            _vScrollBar.setThumbPercent(vPercent);
            _vScrollBar.max = Math.max(0, maxHeight - height);
            _vScrollBar.height = height - 1;
            
            
            _hScrollBar.setThumbPercent(hPercent);
            _hScrollBar.max = Math.max(0, maxWidth - width);
            _hScrollBar.width = width - 1;
            
            content.x = -_hScrollBar.value;
            content.y = -_vScrollBar.value;
        }
        
        
        
    }
}