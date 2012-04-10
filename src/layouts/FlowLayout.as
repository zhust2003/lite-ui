package layouts
{
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    
    import layouts.aligns.*;

    /**
     * 流布局管理器。它按照和页面上排列单词的类似方式来安排组件
	 * 从左到右，直至没有多余的空间，然后转到下一行 
     * @author shaotong.zhu
     * 
     */    
    public class FlowLayout extends Layout
    {
        /** 横向间隔 **/
        private var _hgap:Number = 0;
        /** 竖向间隔 **/
        private var _vgap:Number = 0;
        /** 竖直对齐方式 **/
        private var _vAlign:String = VerticalAlignment.TOP;
        
        
        public function FlowLayout()
        {
        }
        
        public function set hgap(s:Number):void {
            _hgap = s;
        }
        
        public function get hgap():Number {
            return _hgap;
        }
        
        public function set vgap(s:Number):void {
            _vgap = s;
        }
        
        public function get vgap():Number {
            return _vgap;
        }
        
        public function set vAlign(a:String):void {
            _vAlign = a;
        }
        
        public function get vAlign():String {
            return _vAlign;
        }
        
        override protected function layout(children:Array):void {
            const startX:Number = padding.left;
            var px:Number = startX;
            var py:Number = padding.top;
            var maxChildHeight:Number = 0;
            var row:Array = [];
            
            // 遍历所有子元素
            for (var i:uint = 0, l:uint = children.length; i < l; ++i) {
                var child:DisplayObject = children[i];
                
                // 是否到了布局边缘
                // 换行，重新计算最大子元素高度
                if ((px + child.width + padding.right) > width) {
                    _alignRow(row, maxChildHeight);
                    px = startX;
                    py += maxChildHeight + vgap;
                    maxChildHeight = 0;
                    row = [];
                }
                child.x = px;
                child.y = py;
                maxChildHeight = Math.max(maxChildHeight, child.height);
                px += (child.width + hgap);
                row.push(child);
            }
            _alignRow(row, maxChildHeight);
            
        }
        
        private function _alignRow(row:Array, maxChildHeight:Number):void {
            for (var i:uint = 0, l:uint = row.length; i < l; ++i) {
                var child:DisplayObject = DisplayObject(row[i]);
                align(child, new Rectangle(child.x, child.y, child.width, maxChildHeight), null, _vAlign);
            }
        }
    }
}