package components
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import skins.SkinMgr;
	import skins.Style;

	public class Button extends Component
	{
		private var _labelText:String = "按钮文本";
		protected var _label:Label;
		
		
		public function Button(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, label:String = "", defaultHandler:Function = null)
		{
			// 默认的样式名
			styleName = 'button';
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
            _labelText = label;
		}
        
		
		override public function init():void {
            super.init();
            
			buttonMode = true;
			useHandCursor = true;
			
			_label = new Label();
			addChild(_label);
			
		}
		
		override public function render():void {
            super.render();
            
            
            
            // 标签样式
            var fontStyles:Array = ["color", "fontSize", "fontFamily", "stroke", "dropShadow"];
            var labelStyle:Style = new Style();
            for each(var fontStyle:String in fontStyles) {
                labelStyle[fontStyle] = _renderStyle[fontStyle];
            }

            _label.style = labelStyle;
            
            
            // 标签文本
            _label.text = _labelText;
            
            // 强制刷新一次，否则第一次宽高会有问题
            _label.render();
            
            // 对齐标签位置
            _label.x = (width - _label.width) / 2;
            _label.y = (height - _label.height) / 2;
		}
		
		public function set label(str:String):void
		{
			_labelText = str;
			markForRender();
		}
        
		public function get label():String
		{
			return _labelText;
		}
	}
}