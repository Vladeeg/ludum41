package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState 
{
	
	private var back:FlxSprite;
	private var text:FlxText;
	
	override public function create():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		back = new FlxSprite();
		back.loadGraphic("assets/images/start.png");
		add(back);
		
		text = new FlxText(0, 0, 800, "Cards'n'Guns", 40);
		text.alignment = FlxTextAlign.CENTER;
		text.font = "assets/fonts/10692.ttf";
		text.screenCenter();
		text.y = 2;
		text.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4);
		add(text);
		
		var startBtn:FlxButton = new FlxButton(0, 0, "Начать", onClick);
		startBtn.pixelPerfectRender = true;
		startBtn.loadGraphic("assets/images/button.png", true, 141, 42);
		startBtn.label.setFormat("assets/fonts/10692.ttf", 23, 0x3B3B3B, FlxTextAlign.CENTER);
		startBtn.screenCenter();
		startBtn.y = 350;
		add(startBtn);
		
		super.create();
	}
	
	private function onClick()
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
		{
			FlxG.switchState(new PlayState());
		});
	}
	
}