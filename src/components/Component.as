package components
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import skins.SkinMgr;
	import skins.Style;
	
	public class Component extends Sprite
	{
        protected var _padding:Number = 0;
        protected var _marging:Number = 0;
        
		protected var _enabled:Boolean = true;
        
		protected var _styleName:String;
        protected var _style:Style;
        protected var _renderStyle:Style;
        
        
        private var _background:Sprite;
        
        private var _over:Boolean = false;
        private var _down:Boolean = false;
        protected var _checked:Boolean = false;
		
		public function Component(parent:DisplayObjectContainer, xpos:Number = 0, ypos:Number =  0)
		{
            // 移动到指定位置
            move(xpos, ypos);
            // 初始化样式
//            initStyle();
            // 初始化元素
			init();
            
            
			if(parent != null)
			{
				parent.addChild(this);
			}
		}
        
        
		protected function move(xpos:Number, ypos:Number):void
		{
			x = xpos;
			y = ypos;
		}
		
		public function setSize(w:Number, h:Number):void {
			width = w;
			height = h;
		}
		
		// 初始化
		public function init():void {
            _background = new Sprite();
            if (this is Panel) {
                Panel(this).addRawChild(_background);
            } else {
                addChild(_background);
            }
            
            
            addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			markForRender();
		}
        
        protected function onMouseUp(event:MouseEvent):void
        {
            _down = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            markForRender();
        }
        
        protected function onMouseOver(event:MouseEvent):void
        {
            _over = true;
            addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            markForRender();
        }
        
        protected function onMouseOut(event:MouseEvent):void
        {
            _over = false;
            removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            markForRender();
        }
        
        protected function onMouseDown(event:MouseEvent):void
        {
            _down = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            markForRender();
        }
        
        public function set checked(s:Boolean):void
        {
            _checked = s;
            markForRender();
        }
        
        
        public function get checked():Boolean
        {
            return _checked;
        }
        
        /**
         * 初始化样式 
         * 
         */        
        protected function initStyle():void
        {
            _style = SkinMgr.getInstance().getStyle(styleName).clone();
        }
		
		override public function set width(w:Number):void {
            style.width =  w;
			markForRender();
		}
		
		override public function get width():Number {
			return style.width;
		}
		
		override public function set height(h:Number):void {
            style.height = h;
			markForRender();
		}
		
		override public function get height():Number {
			return style.height;
		}
		
		// 只有在下一帧进行渲染
		// 因为xml里面，有可能经常设置属性，如果设置属性的同时，经常渲染，就不划算了
		protected function markForRender():void {
			addEventListener(Event.ENTER_FRAME, _render);
		}
		
		private function _render(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, _render);
			render();
		}
		
		public function render():void {
            
            // 默认是当前样式
            _renderStyle = style;
            
            // 如果改变了状态，重新获取样式
            if (_down) {
                _renderStyle = style.getPseudoStyle(styleName, 'down');
            } else if(_over) {
                _renderStyle = style.getPseudoStyle(styleName, 'over');
            }
            if (_checked) {
                _renderStyle = style.getPseudoStyle(styleName, 'checked');
            }
            
            // 绘制背景图片
            _background.graphics.clear();
            if (_renderStyle.backgroundImage) {
                var background:BitmapData = _renderStyle.background;
                _background.graphics.beginBitmapFill(background, null, false);
                _background.graphics.drawRect(0, 0, background.width, background.height);
                _background.graphics.endFill();
            }
            
            // 设置透明度
            alpha = _renderStyle.alpha;
            
 		}
        
        protected function get background():Sprite {
            return _background;
        }
        
        protected function renderTextStyle(tf:TextField):void {
            tf.setTextFormat(new TextFormat(_renderStyle.fontFamily, _renderStyle.fontSize, _renderStyle.color));
            
            var filters:Array = [];
            if (style.dropShadow) {
                var params:Array = style.dropShadow;
                filters.push(new DropShadowFilter(params[0], params[1], params[2], params[3]));
            }
            if (style.stroke) {
                filters.push(new GlowFilter(style.stroke, 1, 2, 2, 16));
            }
            tf.filters = filters;
        }
		
		public function set styleName(s:String):void {
            _styleName = s;
            initStyle();
			markForRender();
		}
		
		public function get styleName():String {
			return _styleName;
		}
        
        public function get style():Style {
            return _style;
        }
        public function set style(s:Style):void {
            _style = s;
            markForRender();
        }
        
		public function set enabled(value:Boolean):void {
			_enabled = value;
			mouseEnabled = mouseChildren = _enabled;
			tabEnabled = value;
			alpha = _enabled ? 1.0 : 0.5;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
	}
}