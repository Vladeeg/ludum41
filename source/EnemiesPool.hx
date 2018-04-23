package;
import flixel.FlxG;

class EnemiesPool 
{

	private var typesPool:Array<String>;
	private var hpPool:Map<String, Int>;
	private var dmgPool:Map<String, Int>;
	
	public function new() 
	{
		typesPool = new Array<String>();
		hpPool = new Map<String, Int>();
		dmgPool = new Map<String, Int>();
		
		typesPool.push("slime");
		typesPool.push("reptile");
		typesPool.push("bot");
		typesPool.push("alien");
		typesPool.push("face");
		
		hpPool.set("slime", 2);
		hpPool.set("reptile", 4);
		hpPool.set("bot", 6);
		hpPool.set("alien", 8);
		hpPool.set("face", 10);
		
		dmgPool.set("slime", 1);
		dmgPool.set("reptile", 2);
		dmgPool.set("bot", 3);
		dmgPool.set("alien", 4);
		dmgPool.set("face", 4);
	}
	
	public function getRandomType():String
	{
		return typesPool[FlxG.random.int(0, typesPool.length - 1)];
	}
	
	public function getWaveType(wave:Int):String
	{
		return typesPool[wave];
	}
	
	public function getHp(type:String):Int
	{
		return hpPool.get(type);
	}
	
	public function getDmg(type:String):Int
	{
		return dmgPool.get(type);
	}
}
