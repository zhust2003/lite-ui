package components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;

	public class TextInput extends Component
	{		
		protected var _password:Boolean = false;
		protected var _text:String = "";
		protected var _tf:TextField;
		
		
		public function TextInput(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, text:String = "")
		{
            // 默认的样式名
            styleName = 'textInput';
			super(parent, xpos, ypos);
			_text = text;
		}
		
		override public function init():void {
            super.init();
			
			_tf = new TextField();
            _tf.text = text;
			_tf.selectable = true;
			_tf.type = TextFieldType.INPUT;
			_tf.defaultTextFormat = new TextFormat(style.fontFamily, style.fontSize, style.color);
			addChild(_tf);
		}
		
		override public function render():void {
            super.render();
            
			_tf.x = 2;
			_tf.y = 3;
			_tf.width = width - 2;
			_tf.height = height - 3;
			_tf.displayAsPassword = _password;
            
            super.renderTextStyle(_tf);
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			_tf.tabEnabled = value;
		}
		
		public function set text(t:String):void {
			_text = t;
			markForRender();
		}
		
		public function get text():String {
			return _text;
		}	
		
		public function set password(b:Boolean):void
		{
			_password = b;
			markForRender();
		}
		public function get password():Boolean
		{
			return _password;
		}
		
		public function set maxChars(max:int):void
		{
			_tf.maxChars = max;
		}
		public function get maxChars():int
		{
			return _tf.maxChars;
		}		
		
		public function set restrict(str:String):void
		{
			_tf.restrict = str;
		}
		public function get restrict():String
		{
			return _tf.restrict;
		}
	}
}