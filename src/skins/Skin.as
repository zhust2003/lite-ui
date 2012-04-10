package skins
{
	/**
	 * 皮肤基础类 
	 * @author dalton
	 * 
	 */	
	public class Skin
	{
		public function Skin() {
			
		}
        
        
        public function getStyle(name:String, pseudo:String = ""):Object {
            var style:Object;
            if (name == null || name == "") return null;
            if (hasOwnProperty(name)) {
                style = this[name];
            }
            // 如果有伪属性
            if (pseudo.length > 0) {
                name = name + '$' + pseudo;
                if (hasOwnProperty(name)) {
                    var pseudoStyle:Object = this[name];
                    for (var key:String in pseudoStyle) {
                        style[key] = pseudoStyle[key];
                    }
                }
            }
            return style;
        }
        
	}
}