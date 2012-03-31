package layouts
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    
    public class Layout extends Sprite
    {
        
        public function Layout()
        {
        }
        
        override public function get width():Number {
            
        }
        
        override public function get height():Number {
            
        }
        
        override public function addChild(child:DisplayObject):DisplayObject {
            child = super.addChild(child);
            invalidateLayout();
            return child;
        }
        
        override public function addAtChild(child:DisplayObject, index:uint):DisplayObject {
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
        }
        
        protected function layout(children:Array):void {
            
        }
    }
}