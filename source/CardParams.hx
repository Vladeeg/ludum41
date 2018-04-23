package;
import flixel.FlxG;

class CardParams 
{

	private var namesPool:Map<String, String>;
	private var costsPool:Map<String, Int>;
	private var dmgPool:Map<String, Int>;
	private var descsPool:Map<String, String>;
	private var typesPool:Array<String>;
	
	public function new() 
	{
		namesPool = new Map<String, String>();
		costsPool = new Map<String, Int>();
		dmgPool = new Map<String, Int>();
		descsPool = new Map<String, String>();
		typesPool = new Array<String>();
		
		typesPool.push("stab");
		typesPool.push("shotgun");
		typesPool.push("rage");
		typesPool.push("heal");
		typesPool.push("rifle");
		typesPool.push("gun");
		
		namesPool.set("stab", "Удар ножом");
		namesPool.set("shotgun", "Выстрел из дробовика");
		namesPool.set("rage", "Ярость");
		namesPool.set("heal", "Лечение");
		namesPool.set("rifle", "Очередь из автомата");
		namesPool.set("gun", "Выстрел из пистолета");
		
		costsPool.set("stab", 0);
		costsPool.set("shotgun", 1);
		costsPool.set("rage", 0);
		costsPool.set("heal", 0);
		costsPool.set("rifle", 3);
		costsPool.set("gun", 1);
		
		dmgPool.set("stab", 2);
		dmgPool.set("shotgun", 3);
		dmgPool.set("rage", 2);
		dmgPool.set("heal", 0);
		dmgPool.set("rifle", 6);
		dmgPool.set("gun", 4);
		
		descsPool.set("stab", "Наносит " + dmgPool.get("stab") + " очка урона по одному противнику");
		descsPool.set("shotgun", "Наносит " + dmgPool.get("shotgun") + " очка урона по всем противникам");
		descsPool.set("rifle", "Наносит " + dmgPool.get("rifle") + " очков урона по одному противнику");
		descsPool.set("gun", "Наносит " + dmgPool.get("gun") + " очка урона по одному противнику");
		descsPool.set("rage", "Добавляет " + dmgPool.get("rage") + " очка урона к любой атаке");
		descsPool.set("heal", "Даёт 4 очка здоровья");
	}
	
	public function getName(type:String):String
	{
		return namesPool.get(type);
	}
	public function getCost(type:String):Int
	{
		return costsPool.get(type);
	}
	public function getDesc(type:String):String
	{
		return descsPool.get(type);
	}
	public function getDmg(type:String):Int
	{
		return dmgPool.get(type);
	}
	public function getRandomType():String
	{
		if (PlayState.wave == 0) {
			return typesPool[FlxG.random.int(0, typesPool.length - 1, [1, 2, 4, 5])];
		}
		if (PlayState.wave == 1) {
			return typesPool[FlxG.random.int(0, typesPool.length - 1, [1, 4, 5])];
		}
		if (PlayState.wave == 2) {
			return typesPool[FlxG.random.int(0, typesPool.length - 1, [1, 4])];
		}
		if (PlayState.wave == 3) {
			return typesPool[FlxG.random.int(0, typesPool.length - 1, [4])];
		}
		return typesPool[FlxG.random.int(0, typesPool.length - 1)];
	}
	
}