package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class HUD extends FlxTypedGroup<FlxSprite>
{

	private var txtHealth:FlxText;
	private var txtAmmo:FlxText;
	private var txtPlus:FlxText;
	private var txtMinus:FlxText;
	
	public function new() 
	{
		super();
		txtAmmo = new FlxText(10, 10, 0, "Патроны: 0", 20);
		txtAmmo.font = "assets/fonts/10692.ttf";
		
		txtHealth = new FlxText(10, 10, 0, "Здоровье: 0", 20);
		txtHealth.font = "assets/fonts/10692.ttf";
		
		txtPlus = new FlxText(10, 10, 0, "+0", 20);
		txtPlus.font = "assets/fonts/10692.ttf";
		txtMinus = new FlxText(10, 10, 0, "-0", 20);
		txtMinus.font = "assets/fonts/10692.ttf";
		
		add(txtAmmo);
		add(txtHealth);
	}
	
	public function updateHud(health:Int, ammo:Int)
	{
		txtAmmo.text = "Патроны: " + Std.string(ammo);
		txtHealth.text = "Здоровье: " + Std.string(health);
		txtHealth.x = FlxG.width - 10 - txtHealth.width;
	}
	
}