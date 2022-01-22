package;

import flixel.util.FlxColor;
import openfl.display.BitmapData;
import openfl8.LightingShader;

class LightingEffect
{
	/**
	 * The instance of the actual shader class
	 */
	public var shader(default, null):LightingShader;

	public function new(normalMap:BitmapData, specularMap:BitmapData, frameSizeX:Float, frameSizeY:Float):Void
	{
		shader = new LightingShader();
		shader.worldPos.value = [0, 0];
		shader.frameCoords.value = [0, 0];
		shader.normalMap.input = normalMap;
		shader.specularMap.input = specularMap;
		shader.lightPos.value = [0, 1, 10];
		shader.lightColor.value = [1, 1, 1];
		shader.lightRadius.value = [500];

		shader.frameSize.value = [frameSizeX, frameSizeY];
	}

	public function setLightColor(l: FlxColor)
	{
		
		shader.lightColor.value = [
			l.redFloat,
			l.greenFloat,
			l.blueFloat
		];
	}

	public function updateNormalMap(normalMap:BitmapData)
	{
		shader.normalMap.input = normalMap;
	}

	public function setFrameUV(X:Float, Y:Float)
	{
		shader.frameCoords.value[0] = X;
		shader.frameCoords.value[1] = Y;
	}

	public function setWorldPos(X:Float, Y:Float):Void
	{
		shader.worldPos.value[0] = X;
		shader.worldPos.value[1] = Y;
	}

	public function setLightPosition(X:Float, Y:Float, ?Z:Float):Void
	{
		shader.lightPos.value[0] = X;
		shader.lightPos.value[1] = Y;
		if (Z != null) shader.lightPos.value[2] = Z;
	}

	public function setLightRadius(X:Float):Void
	{
		shader.lightRadius.value[0] = X;
	}
}
