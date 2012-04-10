package layouts
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
    import layouts.aligns.*;

    /**
     * BoxLayout可以将组件由上至下或由左至右依次加入当前面板。 
     * @author shaotong.zhu
     * 
     */    
    public class BoxLayout extends Layout
    {
		/** 横向间隔 **/
		private var _hgap:Number = 0;
		/** 竖向间隔 **/
		private var _vgap:Number = 0;
        /** 方向 **/
        private var _direction:String = D_HORIZ;
        /** 竖直对齐方式 **/
        private var _vAlign:String = VerticalAlignment.TOP;
        /** 横向对齐方式 **/
        private var _hAlign:String = HorizontalAlignment.LEFT;
        
        /** 方向常量 **/
        public static const D_HORIZ:String = "horizontal";
        public static const D_VERT:String = "vertical";
		
        public function BoxLayout(d:String = D_HORIZ)
        {
            _direction = d;
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
        
        public function set direction(d:String):void {
            _direction = d;
        }
        
        public function get direciton():String{
            return _direction;
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
			var maxChildHeight:Number = 0;
            var maxChildWidth:Number = 0;
            
            var i:uint, l:uint, child:DisplayObject;
            
            // 先得到最大宽度及最大高度
            for (i = 0, l = children.length; i < l; ++i) {
                child = children[i];
                maxChildHeight = Math.max(maxChildHeight, child.height);
                maxChildWidth = Math.max(maxChildWidth, child.width);
            }
            
            
            // 遍历所有子元素
            for (i = 0, l = children.length; i < l; ++i) {
                child = children[i];
                if (_direction == D_HORIZ) {
                    child.x = px;
                    px += (child.width + hgap);
                    align(child, new Rectangle(child.x, child.y, child.width, maxChildHeight), null, _vAlign);
                } else {
                    child.y = py;
                    py += (child.height + vgap);
                    align(child, new Rectangle(child.x, child.y, maxChildWidth, child.height), _hAlign, null);
                }
            }
            
		}
    }
}