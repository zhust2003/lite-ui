package components
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class TextArea extends Component
	{
		protected var _tf:TextField;
		private var _scrollBar:ScrollBar;
		private var _text:String;
		private var _html:Boolean;
		private var _selectable:Boolean = true;
		private var _editable:Boolean = true;
		
		public function TextArea(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, text:String = "")
		{
            styleName = 'textArea';
			super(parent, xpos, ypos);
			this.text = text;
		}
		
		override public function init():void {
            super.init();
			
			_scrollBar = new ScrollBar(this);
			
			
			_tf = new TextField();
			_tf.multiline = true;
			_tf.wordWrap = true;
			_tf.selectable = true;
			_tf.type = TextFieldType.INPUT;
			_tf.defaultTextFormat = new TextFormat(style.fontFamily, style.fontSize, style.color);		
			addChild(_tf);
			
			
			// 暂时不使用鼠标自带的滚动，跳得很快
			//addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_scrollBar.addEventListener(Event.CHANGE, onScrollbarScroll);
			
			_tf.addEventListener(Event.SCROLL, onTextScroll);
			_tf.addEventListener(Event.CHANGE, onChange);
		}
		
		protected function onChange(event:Event):void
		{
            _text = _tf.text;
			updateScrollBar();
		}
		
		protected function onTextScroll(event:Event):void
		{
			_scrollBar.value = _tf.scrollV;
			updateScrollBar();
		}
		
		protected function onScrollbarScroll(event:Event):void
		{
			_tf.scrollV = Math.round(_scrollBar.value);
		}
		
		protected function updateScrollBar():void {
			// 可见函数
			var visibleLines:int = _tf.numLines - _tf.maxScrollV + 1;
			// 当前可见与总行数百分比
			var percent:Number = visibleLines / _tf.numLines;
			_scrollBar.setThumbPercent(percent);
			_scrollBar.setParams(1, _tf.maxScrollV, _tf.scrollV);
		}
		
		public function set text(t:String):void {
			_text = t;
			markForRender();
		}
		
		public function get text():String {
			return _text;
		}
		
//		protected function onMouseWheel(event:MouseEvent):void
//		{
//			_scrollBar.value -= event.delta;
//			_tf.scrollV = Math.round(_scrollBar.value);
//		}
		
		override public function render():void {
            super.render();
            
            _scrollBar.render();
            _scrollBar.height = height - 1;
            _scrollBar.x = width - _scrollBar.width;
            
            _tf.x = 2;
            _tf.y = 2;
            _tf.height = height - 2;
            _tf.width = width - _scrollBar.width;
            
            
            super.renderTextStyle(_tf);
            
			if(_html)
			{
				_tf.htmlText = _text;
			} else {
				_tf.text = _text;
			}
			if(_editable)
			{
				_tf.mouseEnabled = true;
				_tf.selectable = true;
				_tf.type = TextFieldType.INPUT;
			}
			else
			{
				_tf.mouseEnabled = _selectable;
				_tf.selectable = _selectable;
				_tf.type = TextFieldType.DYNAMIC;
			}
		}
		
		
		
		public function set editable(b:Boolean):void
		{
			_editable = b;
			markForRender();
		}
		public function get editable():Boolean
		{
			return _editable;
		}
		
		public function set selectable(b:Boolean):void
		{
			_selectable = b;
			markForRender();
		}
		
		public function get selectable():Boolean
		{
			return _selectable;
		}
		
		public function set html(b:Boolean):void
		{
			_html = b;
			markForRender();
		}
		
		public function get html():Boolean
		{
			return _html;
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			_tf.tabEnabled = value;
		}
	}
}