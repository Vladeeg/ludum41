package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText.FlxTextAlign;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class GameoverState extends FlxState 
{

	private var back:FlxSprite;
	
	override public function create():Void
	{
		back = new FlxSprite();
		back.loadGraphic("assets/images/losescreen.png");
		add(back);
		
		var closeBtn = new FlxButton(0, 0, "Сначала", onClick);
		closeBtn.pixelPerfectRender = true;
		closeBtn.loadGraphic("assets/images/button_wider.png", true, 149, 42);
		closeBtn.label.setFormat("assets/fonts/10692.ttf", 23, 0x3B3B3B, FlxTextAlign.CENTER);
		closeBtn.screenCenter();
		closeBtn.y = 500;
		add(closeBtn);
		
		super.create();
	}
	
	private function onClick()
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
		{
			FlxG.switchState(new MenuState());
		});
	}
	
}