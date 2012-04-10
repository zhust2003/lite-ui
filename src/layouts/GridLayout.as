package layouts
{
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    
    import layouts.aligns.*;
    /**
     * 网格布局，或者可以理解为表格布局
     * 每行每列的宽高由当行当列最大的元素宽高决定
     * @author shaotong.zhu
     * 
     */    
    public class GridLayout extends Layout
    {
        /** 横向间隔 **/
        private var _hgap:Number = 0;
        /** 竖向间隔 **/
        private var _vgap:Number = 0;
        
        /** 竖直对齐方式 **/
        private var _vAlign:String = VerticalAlignment.TOP;
        /** 横向对齐方式 **/
        private var _hAlign:String = HorizontalAlignment.LEFT;
        
        /** 方向常量 **/
        public static const D_HORIZ:String = "horizontal";
        public static const D_VERT:String = "vertical";
        
        /** 列数 **/
        private var _cols:uint = 2;
        
        /** 每个网格宽高 **/
        private var _gWidth:Number = NaN;
        private var _gHeight:Number = NaN;
        
        public function GridLayout(c:uint)
        {
            _cols = c;
        }
        
        public function set cols(x:uint):void {
            _cols = x;
        }
        
        public function get cols():uint {
            return _cols;
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
        
        public function set hAlign(a:String):void {
            _hAlign = a;
        }
        
        public function get hAlign():String {
            return _hAlign;
        }
        
        override protected function layout(children:Array):void {
            const startX:Number = padding.left;
            var px:Number = startX;
            var py:Number = padding.top;
            var maxChildHeight:Array = [];
            var maxChildWidth:Array = [];
            
            var rowChildHeight:Number = 0;
            var colChildren:Array = [];
            
            var i:uint, 
                l:uint, 
                nowRow:uint,
                nowCol:uint,
                child:DisplayObject,
                colChild:Array;
            
            // 先得到最大宽度及最大高度
            for (i = 0, l = children.length; i < l; ++i) {
                child = children[i];
                nowRow = Math.floor(i / cols);
                nowCol = i % _cols;
                rowChildHeight = Math.max(rowChildHeight, child.height);
                colChild = colChildren[nowCol];
                if (! colChild) {
                    colChild = [];
                    colChildren[nowCol] = colChild;
                }
                colChild.push(child);
                
                maxChildHeight[nowRow] = rowChildHeight;
                // 如果有预设格子高宽，则使用格子高宽
                if(! isNaN(_gHeight)) {
                    maxChildHeight[nowRow] = _gHeight;
                }
                
                // 如果换行了，重设行高
                if ((i + 1) % _cols == 0) {
                    rowChildHeight = 0;
                }
            }
            
            var colChildWidth:Number = 0;
            for (var col:uint = 0, allCol:uint = colChildren.length; col < allCol; ++col) {
                colChild = colChildren[col];
                for (i = 0, l = colChild.length; i < l; ++i) {
                    child = colChild[i];
                    colChildWidth = Math.max(colChildWidth, child.width);
                }
                maxChildWidth[col] = colChildWidth;
                colChildWidth = 0;
                // 如果有预设格子高宽，则使用格子高宽
                if(! isNaN(_gWidth)) {
                    maxChildWidth[col] = _gWidth;
                }
            }
            
            
            // 遍历所有子元素
            for (i = 0, l = children.length; i < l; ++i) {
                child = children[i];
                nowRow = Math.floor(i / cols);
                nowCol = i % _cols;
                child.x = px;
                child.y = py;
                px += (maxChildWidth[nowCol] + hgap);
                
                align(child, new Rectangle(child.x, child.y, child.width, maxChildHeight[nowRow]), null, _vAlign);
                
                // 如果需要换行了
                if ((i + 1) % _cols == 0) {
                    py += maxChildHeight[nowRow] + vgap;
                    px = startX;
                }
            }
        }
    }
}