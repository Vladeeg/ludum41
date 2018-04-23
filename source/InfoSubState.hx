package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;

class InfoSubState extends FlxSubState 
{

	private var ttl:Int;
	private var back:FlxSprite;
	
	public function new() 
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		super(FlxColor.BLACK);
		back = new FlxSprite();
		
		back.loadGraphic("assets/images/govna_paket.png");
		add(back);
		
		ttl = 200;
		
	}
	
	private function onClick()
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		close();
	}
	
	public static function onSubstateClose():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .7, true);
	}
	
	override public function update(elapsed:Float) {
		if (ttl > 0) {
			--ttl;
		}
		
		if (ttl <= 0) {
			onClick();
		}
		
		if (FlxG.mouse.justPressed) {
			onClick();
		}
		
		back.update(elapsed);
		super.update(elapsed);
	}
	
	
}