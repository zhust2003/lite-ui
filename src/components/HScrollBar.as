package components
{
    import flash.display.DisplayObjectContainer;
    
    public class HScrollBar extends ScrollBar
    {
        public function HScrollBar(parent:DisplayObjectContainer, xpos:Number=0, ypos:Number=0)
        {
            super(parent, xpos, ypos, ScrollBar.HORIZONTAL);
        }
    }
}