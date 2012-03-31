package
{
	import components.Button;
	import components.CheckBox;
	import components.ComboBox;
	import components.HScrollBar;
	import components.Label;
	import components.List;
	import components.Panel;
	import components.Radio;
	import components.RadioGroup;
	import components.ScrollBar;
	import components.ScrollPane;
	import components.TextArea;
	import components.TextInput;
	import components.VScrollBar;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
    
    import flash.events.MouseEvent;
	
    
    [SWF(width="800", height="600", frameRate="60")]
	public class Main extends Sprite
	{
		
		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
            
			
			addChild(new Label(this, 10, 0, "中文字"));
			addChild(new Button(this, 10, 20, "确定"));
			addChild(new TextInput(this, 10, 60, "test"));
//            new HScrollBar(this, 300, 300);
//            new VScrollBar(this, 320, 300);
			addChild(new TextArea(this, 10, 120));
			addChild(new Panel(this, 300, 0));

			var p:ScrollPane = new ScrollPane(this, 300, 120);
			new Button(p, 10, 10, "确定");
			new Button(p, 10, 50, "确定");
			new Button(p, 10, 101, "确定");
			new Button(p, 10, 150, "确定");
			new Button(p, 10, 200, "确定");
			new Button(p, 10, 1000, "确定");
			new Button(p, 500, 200, "确定");
            
            var group:RadioGroup = new RadioGroup();
            var radio:Radio = new Radio(this, 10, 350, group, "选项一");
            var radio2:Radio = new Radio(this, 80, 350, group, "选项二");
            
            var checkBox:CheckBox = new CheckBox(this, 10, 400, "多选一");
            var checkBox2:CheckBox = new CheckBox(this, 80, 400, "多选二", 1, true);
            
            var list:List = new List(this, 10, 450);
            list.addItem("item1", 1);
            list.addItem("item2", 2);
            list.addItem("item3", 3);
            list.addItem("item4", 3);
            list.addItem("item5", 3);
            list.addItem("item5", 3);
            
            var combobox:ComboBox = new ComboBox(this, 150, 450);
            
		}
    }
}