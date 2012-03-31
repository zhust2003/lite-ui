package skins
{
	public class DefaultSkin extends Skin {
        public var label:Style;
        public var button:Style;
        public var button$over:Object;
        public var button$down:Object;
        
        public var textInput:Style;
        public var textArea:Style;
        public var scrollBar:Style;
        public var scrollBarThumb:Style;
        
        public var panel:Style;
        
        public var radio:Style;
        public var radio$over:Object;
        public var radio$down:Object;
        public var radio$checked:Object;
        
        public var checkBox:Style;
        public var checkBox$checked:Object;
        
        public var list:Style;
        public var listItem:Style;
        public var listItem$over:Object;
        
        public var combobox:Style;
        public var combobox$down:Object;
        
		public function DefaultSkin() {
    		/**
    		 * 标签相关样式 
    		 * 标签没有伪样式
    		 */	
            label = new Style();
            label.color = 0x777777;
            label.fontSize = 12;
            label.fontFamily = "Verdana";
            
            
            /**
             * 按钮相关样式 
             * 伪样式可以继承主样式
             */		
            button = new Style();
            button.color = 0x777777;
            button.fontSize = 12;
            button.fontFamily = "Verdana";
            button.dropShadow = [1, 90, 0xFFFFFF, 0.9];
            
            button.width = 83;
            button.height = 34;
            
            button.backgroundImage = Assets.ButtonUp;
            button.backgroundScale = [2, 2, 79, 30];
            
            /**
             * 鼠标移到上面的伪样式 
             */   
            button$over = {};
            button$over.backgroundImage = Assets.ButtonOver;
            
            /**
             * 鼠标按下的伪样式 
             */        
            button$down = {};
            button$down.color = 0xFFFFFF;
            button$down.dropShadow = [1, 90, 0x0, 0.4];
            button$down.backgroundImage = Assets.ButtonDown;
            
            /** 
             * 输入框样式
             */
            textInput = new Style();
            textInput.color = 0x777777;
            textInput.fontSize = 12;
            textInput.fontFamily = "Verdana";
            
            textInput.width = 100;
            textInput.height = 24;
            
            textInput.backgroundImage = Assets.InputBg;
            textInput.backgroundScale = [3, 3, 296, 31];
            textInput.backgroundSize = [100, 24]; 
            
            /**
             * 滚动条样式
             */ 
            scrollBar = new Style();
            scrollBar.backgroundImage = Assets.ScrollBarBg;
            scrollBar.backgroundScale = [7, 2, 286, 13];
            scrollBar.backgroundSize = [300, 17];
            
            scrollBarThumb = new Style();
            scrollBarThumb.backgroundImage = Assets.ScrollBarThumb;
            scrollBarThumb.backgroundScale = [5, 1, 207, 14];
            scrollBarThumb.backgroundSize = [217, 16];
            
            /**
             * 多行文本框样式
             */
            textArea = new Style();
            
            textArea.width = 200;
            textArea.height = 200;
            textArea.backgroundImage = Assets.InputBg;
            textArea.backgroundScale = [3, 3, 296, 31];
            textArea.backgroundSize = [200, 200];
            
            /**
             * 面板样式
             */
            panel = new Style();
            panel.backgroundImage = Assets.PanelBg;
            panel.backgroundScale = [2, 2, 296, 33];
            panel.backgroundSize = [100, 100];
            panel.width = 100;
            panel.height = 100;
            
            /**
             * 单选框样式
             */
            radio = new Style();
            radio.backgroundImage = Assets.RadioNone;
            
            /**
             * 单选框选中样式
             */
            radio$checked = {};
            radio$checked.backgroundImage = Assets.Radio;
            
            /**
             * 多选框样式
             */
            checkBox = new Style();
            checkBox.backgroundImage = Assets.CheckNone;
            
            /**
             * 多选框选中样式
             */
            checkBox$checked = {};
            checkBox$checked.backgroundImage = Assets.Check;
            
            
            /** 
             * 列表样式
             */
            list = new Style();
            list.backgroundImage = Assets.List;
            list.backgroundScale = [1, 1, 183, 92];
            list.backgroundSize = [100, 94];
            list.width = 100;
            list.height = 94;
            
            listItem = new Style();
            
            listItem$over = {};
            listItem$over.backgroundImage = Assets.ListItemOver;
            listItem$over.backgroundScale = [0, 0, 101, 27];
            listItem$over.backgroundSize = [100, 18];
            listItem$over.color = 0xFFFFFF;
            
            /**
             * 组合框样式
             */
            combobox = new Style();
            combobox.backgroundImage = Assets.ComboBox;
            
            combobox$down = {};
            combobox$down.backgroundImage = Assets.ComboBoxDown;
        }
			
	}
}