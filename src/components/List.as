package components
{
    import flash.display.DisplayObjectContainer;
    
    public class List extends ScrollPane
    {
        private var _list:Vector.<Label> = new Vector.<Label>();
        
        public function List(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
        {
            super(parent, xpos, ypos);
            styleName = 'list';
        }
        
        override public function init():void {
            super.init();
        }
        
        override public function render():void {
            var nowY:Number = 0;
            for each (var l:Label in _list) {
                l.render();
                l.y = nowY;
                nowY += l.height;
            }
            
            super.render();
        }
        
        public function addItem(label:String, value:Object):void {
            var l:Label = new Label(this);
            l.text = label;
            l.styleName = styleName + 'Item';
            l.autoSize = false;
            l.width = width;
            _list.push(l);
            markForRender();
        }
    }
}