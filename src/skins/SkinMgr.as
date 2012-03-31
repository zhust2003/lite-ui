package skins
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;

	public class SkinMgr
	{
		private var _skin:Skin = new DefaultSkin();
		private static var _instance:SkinMgr;
		
		public function SkinMgr()
		{
		}
        
        public function get skin():Skin {
            return _skin;
        }
		
		public static function getInstance():SkinMgr {
			if(SkinMgr._instance == null) {
				SkinMgr._instance = new SkinMgr();
			}
			return SkinMgr._instance;
		}
        
        public function clone(style:Object):Object{
            var bytes : ByteArray = new ByteArray();
            bytes.writeObject(style);
            bytes.position = 0;
            return bytes.readObject() as Object;
        }
		
		public function getStyle(name:String, pseudo:String = ""):Style {
			if (name == null || name == "") return null;
            
            var style:Style = new Style();
			if (_skin.hasOwnProperty(name)) {
                style = Style(_skin[name]).clone();
            }
            
			// 如果有伪属性
			if (pseudo.length > 0) {
				name = name + '$' + pseudo;
                if (_skin.hasOwnProperty(name)) {
                    var pseudoStyle:Object = _skin[name];
                    for (var key:String in pseudoStyle) {
                        style[key] = pseudoStyle[key];
                    }
                }
			}
			return style;
		}
        
	}
}