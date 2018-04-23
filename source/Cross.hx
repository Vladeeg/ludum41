package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Cross extends FlxSprite 
{
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/cross.png", false, 21, 21);
		set_pixelPerfectRender(true);
		active = false;
	}
	
	override public function update(elapsed:Float)
	{
		visible = active;
		super.update(elapsed);
	}
}