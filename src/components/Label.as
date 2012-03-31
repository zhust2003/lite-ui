package components
{
	import flash.display.DisplayObjectContainer;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.filters.GlowFilter;
    import skins.SkinMgr;

	public class Label extends Component
	{
		protected var _autoSize:Boolean = true;
		protected var _text:String = "";
		protected var _tf:TextField;
		private var _filters:Array = [];
		
		public function Label(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, text:String = "")
		{
            styleName = 'label';
			_text = text;
			super(parent, xpos, ypos);
		}
		
		public function set text(t:String):void {
			this._text = t;
			markForRender();
		}
		
		public function get text():String {
			return _text;
		}
		
		public function set autoSize(b:Boolean):void {
			_autoSize = b;
			markForRender();
		}
		
		public function get autoSize():Boolean {
			return _autoSize;
		}
		
		override public function init():void {      
            super.init();      
            
            style.height = 18;
			_tf = new TextField();
			_tf.selectable = false;
			_tf.mouseEnabled = false;
            _tf.height = width;
			_tf.defaultTextFormat = new TextFormat(style.fontFamily, style.fontSize, style.color);
			_tf.text = _text;			
			_tf.filters = _filters;
			addChild(_tf);
			
			setSize(_tf.textWidth, _tf.textHeight);
		}
		
		override public function render():void {
            _tf.text = _text;
            style.height = _tf.height = 18;
            
			if(_autoSize)
			{
				_tf.autoSize = TextFieldAutoSize.LEFT;
                style.width = _tf.width;
			}
			else
			{
				_tf.autoSize = TextFieldAutoSize.NONE;
				_tf.width = width;
			}
            
            super.render();
            
            
            super.renderTextStyle(_tf);
            
            
            
		}
	}
}