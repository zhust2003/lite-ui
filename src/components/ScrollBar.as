package components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.BitmapAsset;
	
	
	
	[Event(name="change", type="flash.events.Event")]
	public class ScrollBar extends Component
	{
		private var _thumb:Button;
		
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		private var _orientation:String;
		private var _value:Number = 0;
		protected var _max:Number = 100;
		protected var _min:Number = 0;
		private var _thumbPercent:Number = 1;
		
		[Event(name="change", type="flash.events.Event")]
		public function ScrollBar(parent:DisplayObjectContainer, xpos:Number=0, ypos:Number=0, orientation:String = ScrollBar.VERTICAL)
		{
            styleName = 'scrollBar';
			_orientation = orientation;
			super(parent, xpos, ypos);
		}
		
		override public function init():void {
            super.init();
            
			if (_orientation == VERTICAL) {
                style.rotation = 90;
                setSize(17, 300);
			} else {
                setSize(300, 17);
            }
			
            _thumb = new Button(this);
            _thumb.styleName = styleName + 'Thumb';
            if (_orientation == VERTICAL) {
                _thumb.style.rotation = 90;
                setSize(16, 217);
            } else {
                setSize(217, 16);
            }
			
            _thumb.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
		}
		
		public function setParams(min:Number, max:Number, value:Number):void
		{
			this.min = min;
			this.max = max;
			this.value = value;
		}
		
		public function setThumbPercent(value:Number):void {
			_thumbPercent = Math.min(value, 1.0);
			markForRender();
		}
		
		protected function onDrag(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onScroll);

			if (_orientation == VERTICAL) {
                _thumb.startDrag(false, new Rectangle(0, 0, 0, height - _thumb.height));
			} else {
                _thumb.startDrag(false, new Rectangle(0, 0, width - _thumb.width, 0));
			}

		}
		
		protected function onScroll(event:MouseEvent):void
		{
			var oldValue:Number = _value;
			if (_orientation == VERTICAL) {
				_value = _thumb.y / (height - _thumb.height) * (max - min) + min;
			} else {
				_value = _thumb.x / (width - _thumb.width) * (max - min) + min;
			}
			if(_value != oldValue)
			{
				dispatchEvent(new Event(Event.CHANGE));
			}
			
		}
		
		protected function onDrop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onScroll);
			stopDrag();
		}
		
		public function set value(v:Number):void
		{
			_value = v;
			_correctValue()
			markForRender();
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set min(m:Number):void {
			_min = m;
			_correctValue()
			markForRender();
		}
		
		public function get min():Number {
			return _min;
		}
		
		public function set max(m:Number):void {
			_max = m;
			_correctValue()
			markForRender();
		}
		
		public function get max():Number {
			return _max;
		}
		
		override public function render():void {
            super.render();
			// 如果还没达到不可见，则默认滚动条隐藏
			if (_thumbPercent == 1) {
				this.visible = false;
			} else {
				this.visible = true;
			}
            
			// 重新渲染的时候，重新设定高度及位置
			if (_orientation == VERTICAL) {
                _thumb.height = _thumb.style.backgroundSize[0] = height * _thumbPercent;
                _thumb.y = (_value - min) / (max - min) * (height - _thumb.height);
			} else {
                _thumb.width = _thumb.style.backgroundSize[0] = width * _thumbPercent;
                _thumb.x = (_value - min) / (max - min) * (width - _thumb.width);
			}
		}
        
        override public function set height(h:Number):void {
            if (_orientation == VERTICAL) {
                style.backgroundSize[0] = h;
            } else {
                style.backgroundSize[1] = h;
            }
            style.height = h;
            markForRender();
        }
        
        override public function set width(w:Number):void {
            if (_orientation == VERTICAL) {
                style.backgroundSize[1] = w;
            } else {
                style.backgroundSize[0] = w;
            }
            style.width = w;
            markForRender();
        }
		
		
		private function _correctValue():void {
			_value = Math.min(_value, _max);
			_value = Math.max(_value, _min);
		}
	}
}