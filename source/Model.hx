package;
import flixel.FlxG;

class Model 
{

	private var hp:Int;
	private var damage:Int;
	private var ammo:Int;
	private var aoe:Bool;
	private var currentAttack:String;
	
	public function new() 
	{
		hp = 20;
		damage = 0;
		ammo = 0;
		aoe = false;
	}
	
	public function dropModel()
	{
		damage = 0;
		aoe = false;
	}
	
	public function hurt(x:Int)
	{
		hp -= x;
	}
	
	public function addDamage(x:Int, aoe:Bool = false)
	{
		damage += x;
		this.aoe = aoe;
	}
	
	public function getDamage():Int
	{
		return damage;
	}
	
	public function getHealth():Int
	{
		return hp;
	}
	
	public function addHealth(x:Int)
	{
		hp += x;
	}
	
	public function getAmmo():Int
	{
		return ammo;
	}
	
	public function addAmmo()
	{
		ammo += FlxG.random.int(0, 2);
	}
	
	public function reduceAmmo(x:Int)
	{
		ammo -= x;
	}
	
	public function isAoe():Bool
	{
		return aoe;
	}
	
	public function setCurrentAttack(x:String)
	{
		currentAttack = x;
	}
	
	public function getCurrentAttack():String
	{
		return currentAttack;
	}
	
}