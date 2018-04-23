package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Card extends FlxSprite 
{

	private var params:CardParams;
	public static inline var WIDTH:Int = 196;
	public static inline var HEIGHT:Int = 273;
	public var type:String;
	
	private var cost:Int;
	private var dmg:Int;
	
	private var nameText:FlxText;
	private var costText:FlxText;
	private var descriptionText:FlxText;
	
	public function new(X:Float=0, Y:Float=0, type:String = "stab") 
	{
		super(X, Y);
		this.type = type;
		loadGraphic("assets/images/card_" + type + ".png");
		this.params = new CardParams();
		
		cost = params.getCost(type);
		dmg = params.getDmg(type);
		
		nameText = new FlxText(0, 0, 113, params.getName(type), 14);
		nameText.font = "assets/fonts/10692.ttf";
		nameText.color = FlxColor.BLACK;
		nameText.alignment = FlxTextAlign.CENTER;
		nameText.antialiasing = true;
		
		costText = new FlxText(0, 0, 20, Std.string(cost), 16);
		costText.font = "assets/fonts/10692.ttf";
		costText.color = FlxColor.BLACK;
		costText.alignment = FlxTextAlign.CENTER;
		costText.antialiasing = true;
		
		descriptionText = new FlxText(0, 0, 148, params.getDesc(type), 12);
		descriptionText.font = "assets/fonts/10692.ttf";
		descriptionText.color = FlxColor.BLACK;
		descriptionText.alignment = FlxTextAlign.CENTER;
		descriptionText.antialiasing = true;
		
		stamp(nameText, 57, 16);
		stamp(costText, 14, 22);
		stamp(descriptionText, 20, 208);
		
		antialiasing = true;
	}
	
	public function getCost():Int
	{
		return cost;
	}
	
	public function getDmg():Int
	{
		return dmg;
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

}