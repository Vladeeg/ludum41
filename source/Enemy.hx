package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class Enemy extends FlxSprite 
{

	private var params:EnemiesPool;
	private var type:String;
	private var dmg:Int;
	private var defaultPosition:FlxPoint;
	public var shake:Bool;
	private var speed:Float;
	
	public var healthInfo:FlxText;
	
	
	
	public function new(X:Float=0, Y:Float=0, type:String = "slime") 
	{
		super(X, Y);
		loadGraphic("assets/images/enemy_" + type + ".png", true, 250, 250);
		params = new EnemiesPool();
		
		speed = FlxG.random.float( -20, 20);
		
		defaultPosition = new FlxPoint(X, Y);
		
		this.type = type;
		
		if (type == "face")
		{
			animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7], 12);
			animation.add("hurt", [8, 8, 8], 12, false);
			animation.add("shoot", [9, 0, 9, 0, 9, 0, 9, 0], 12, false);
		}
		if (type == "slime") 
		{
			animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 12);
			animation.add("hurt", [11, 11, 11], 12, false);
			animation.add("shoot", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 12], 12, false);
		}
		if (type == "bot")
		{
			animation.add("idle", [0, 1, 2, 3, 4, 5], 12);
			animation.add("hurt", [16, 16, 16], 12, false);
			animation.add("shoot", [6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 12, false);
		}
		if (type == "reptile")
		{
			animation.add("idle", [0, 1, 2, 3, 4, 5, 6], 12);
			animation.add("hurt", [12, 12, 12], 12, false);
			animation.add("shoot", [7, 8, 9, 10, 11], 12, false);
		}
		if (type == "alien")
		{
			animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7], 12);
			animation.add("hurt", [8, 8, 8], 12, false);
			animation.add("shoot", [9, 10, 11, 12, 13, 14, 15], 12, false);
		}
		
		health = params.getHp(type);
		dmg = params.getDmg(type);
		
		healthInfo = new FlxText(X + width * 0.5, Y - 25, 0, Std.string(health) + "/" + Std.string(health), 20);
		healthInfo.font = "assets/fonts/10692.ttf";
		animation.play("idle");
	}
	
	public function getDmg():Int
	{
		return dmg;
	}
	
	public function playAnimationShoot()
	{
		FlxG.sound.play("assets/sounds/" + type + ".wav");
		animation.play("shoot");
	}
	
	override public function hurt(d:Float)
	{
		health -= d;
		healthInfo.text = Std.string(health) + "/" + Std.string(params.getHp(type));
		animation.play("hurt");
	}
	
	private function finishKill(tween:FlxTween) {
		kill();
		PlayState.model.addAmmo();
	}
	
	override public function update(elapsed:Float)
	{		
		healthInfo.setPosition(x + width * 0.5 - healthInfo.width * 0.5, y - 25);
		
		if (x < 45)
		{
			x = 45;
		}
		
		if (x > FlxG.width - 295)
		{
			x = FlxG.width - 295;
		}
		
		if (shake)
		{
			if (FlxG.random.bool(15)) {
				speed = FlxG.random.float( -10, 10);
			}
			x += speed;
		}
		
		if (animation.name != "idle" && animation.finished)
		{
			if (animation.name == "shoot")
			{
				PlayState.model.hurt(dmg);
				FlxG.camera.shake(0.01, 0.2);
				FlxG.camera.flash(FlxColor.RED, 0.1);
			}
			if (health <= 0 && animation.name == "hurt")
			{
				FlxTween.tween(this, { alpha: 0 }, 0.3, { onComplete: finishKill });
			}
			animation.play("idle");
			FlxTween.tween(this, {x: defaultPosition.x}, 0.5);
		}
		
		super.update(elapsed);
	}
	
}