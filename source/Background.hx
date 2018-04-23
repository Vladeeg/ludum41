package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Background extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic("assets/images/back_0.png");
	}
	
	public function changeBack(wave:Int)
	{
		if (wave > 4) {
			wave = 4;
		}
		loadGraphic("assets/images/back_" + Std.string(wave) + ".png");
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
	
}