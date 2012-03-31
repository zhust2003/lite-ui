package skins
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    
    import utils.ScaleBitmap;

    /**
     * 样式类 
     * @author shaotong.zhu
     * 
     */    
    public class Style
    {
        public var color:uint = 0x777777;                           // 字体颜色
        public var fontSize:Number = 12;                            // 字体大小
        public var fontFamily:String = "Verdana";                  // 字体
        public var stroke:uint;                         // 描边
        public var dropShadow:Array;                    // 投影
        
        
        public var width:Number;                        // 宽度
        public var height:Number;                       // 高度
        public var backgroundImage:Class;               // 背景图片
        public var backgroundScale:Array;               // 背景九宫格切
        public var backgroundSize:Array;                // 背景图片大小
        
        public var rotation:int = 0;                    // 默认转向
        
        public var alpha:Number = 1;
        
        // 伪样式
//        public var pseudo:Object = {};
        
        private var _background:BitmapData;
        
        
        public function Style()
        {
        }
        
        public function clone():Style {
            var s:Style = new Style();
            s.color = color;
            s.fontSize = fontSize;
            s.fontFamily = fontFamily;
            s.stroke = stroke;
            s.dropShadow = dropShadow;
            s.width = width;
            s.height = height;
            s.backgroundImage = backgroundImage;
            s.backgroundScale = backgroundScale;
            if (backgroundSize) {
                s.backgroundSize = [backgroundSize[0], backgroundSize[1]];
            }
            s.rotation = rotation;
            s.alpha = alpha;
//            s._background = _background;
            
            return s;
        }
        
        public function getPseudoStyle(name:String, p:String):Style {
            var style:Style = this.clone();
            
            // 如果有伪属性
            var skin:Skin = SkinMgr.getInstance().skin;
            var name:String = name + '$' + p;
            if (skin.hasOwnProperty(name)) {
                var pseudoStyle:Object = skin[name];
                for (var key:String in pseudoStyle) {
                    style[key] = pseudoStyle[key];
                }
            }
            
            return style;
        }
        
        public function get background():BitmapData {
            var image:ScaleBitmap = new ScaleBitmap(Bitmap(new backgroundImage()).bitmapData);
            if (backgroundScale) {
                image.scale9Grid = new Rectangle(backgroundScale[0], backgroundScale[1], backgroundScale[2], backgroundScale[3]);
            }
            if (backgroundSize) {
                image.width = backgroundSize[0];
                image.height = backgroundSize[1];
            }
            
            _background = image.bitmapData.clone();
            
            if (rotation) {
                var matrix:Matrix = new Matrix();
                matrix.translate(-image.width / 2, -image.height / 2);
                matrix.rotate(rotation * (Math.PI / 180));
                var nw:Number = cosd(rotation) * image.width + sind(rotation) * image.height;
                var nh:Number = cosd(rotation) * image.height + sind(rotation) * image.width;
                matrix.translate(nw / 2, nh / 2);
                _background = new BitmapData(nw, nh, true, 0x00000000);
                _background.draw(image.bitmapData, matrix);
            }

            return _background;
        }
        
        private function cosd(x:Number):Number {
            return Math.cos(x * (Math.PI / 180));
        }
        private function sind(x:Number):Number {
            return Math.sin(x * (Math.PI / 180));
        }
    }
}