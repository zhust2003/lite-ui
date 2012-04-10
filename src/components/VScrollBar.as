package components
{
    import flash.display.DisplayObjectContainer;
    
    public class VScrollBar extends ScrollBar
    {
        public function VScrollBar(parent:DisplayObjectContainer, xpos:Number=0, ypos:Number=0)
        {
            super(parent, xpos, ypos, ScrollBar.VERTICAL);
        }
    }
}