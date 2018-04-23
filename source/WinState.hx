package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText.FlxTextAlign;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class WinState extends FlxState 
{

	private var back:FlxSprite;
	
	override public function create():Void
	{
		back = new FlxSprite();
		back.loadGraphic("assets/images/winscreen.png");
		add(back);
		
		var closeBtn = new FlxButton(0, 0, "OK", onClick);
		closeBtn.pixelPerfectRender = true;
		closeBtn.loadGraphic("assets/images/button_winner.png", true, 149, 42);
		closeBtn.label.setFormat("assets/fonts/10692.ttf", 23, 0xE83440, FlxTextAlign.CENTER);
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