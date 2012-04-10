package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Assets
	{
		[Embed(source = "../media/button-down.png")]
		public static const ButtonDown:Class;
		
		[Embed(source = "../media/button-over.png")]
		public static const ButtonOver:Class;
		
		[Embed(source = "../media/button-up.png")]
		public static const ButtonUp:Class;
		
		[Embed(source = "../media/textinput.png")]
		public static const InputBg:Class;
		
		[Embed(source = "../media/scrollbar.png")]
		public static var ScrollBarBg:Class;
		
		[Embed(source = "../media/scrollbar-handle.png")]
		public static var ScrollBarThumb:Class;
		
		[Embed(source = "../media/textinput.png")]
		public static var PanelBg:Class;
		
		[Embed(source = "../media/radio.png")]
		public static var Radio:Class;
		
		[Embed(source = "../media/radio-none.png")]
		public static var RadioNone:Class;
        
        [Embed(source = "../media/checkbox-none.png")]
        public static var CheckNone:Class;
        
        [Embed(source = "../media/checkbox.png")]
        public static var Check:Class;
        
        [Embed(source = "../media/combobox-dropdown.png")]
        public static var List:Class;
        
        [Embed(source = "../media/list_over.png")]
        public static var ListItemOver:Class;
        
        [Embed(source = "../media/combobox.png")]
        public static var ComboBox:Class;
        
        [Embed(source = "../media/combobox-down.png")]
        public static var ComboBoxDown:Class;
        
		public function Assets()
		{
		}
	}
}