package;

import openfl.display.BitmapData;
import flixel.FlxG;
import flixel.util.FlxColor;
import openfl.Assets;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Background extends FlxSprite 
{
	var effect:LightingEffect;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic("assets/images/back_0.png");

		var normalMap = Assets.getBitmapData("assets/images/back_0_n.png");
		var specularMap = new BitmapData(800, 600);
		effect = new LightingEffect(normalMap, specularMap, 800, 600);
		effect.setLightPosition(FlxG.width - 100, 20, 20);
		// effect.setLightColor(FlxColor.ORANGE);
		effect.setLightRadius(1000);
		shader = effect.shader;
	}
	
	public function changeBack(wave:Int)
	{
		if (wave > 4) {
			wave = 4;
		}
		loadGraphic("assets/images/back_" + Std.string(wave) + ".png");
		var normalMap = Assets.getBitmapData("assets/images/back_" + Std.string(wave) + "_n.png");
		var specularMap = new BitmapData(800, 600);
		// var specularMap = Assets.getBitmapData("assets/images/enemy_" + type + "_s.png");
		effect = new LightingEffect(normalMap, specularMap, 800, 600);
		effect.setLightPosition(FlxG.width - 100, 20, 20);
		// effect.setLightColor(FlxColor.ORANGE);
		effect.setLightRadius(1000);
		shader = effect.shader;
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
	
}