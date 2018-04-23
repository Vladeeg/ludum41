package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var cardHolder:CardHolder;
	private var fleeBtn:FlxButton;
	private var params:CardParams;
	private var enemiesPool:EnemiesPool;
	private var enemies:FlxTypedGroup<Enemy>;
	
	private var cross:Cross;
	private var hud:HUD;
	private var enemiesAttackTimer:Int;
	private var background:Background;
	
	public static var model:Model;
	public static var stage:String;
	public static var cardsUsed:Int;
	public static var wave:Int;

	public static var notEnoughAmmoText:FlxText;
	
	override public function create():Void
	{			
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		var infoSubState:InfoSubState = new InfoSubState();
		openSubState(infoSubState);
		
		FlxG.sound.playMusic(FlxAssets.getSound("assets/music/Flyingrupig - Dark Void"));
		
		params = new CardParams();
		enemiesPool = new EnemiesPool();
		
		cardsUsed = 0;
		wave = -1;
		
		background = new Background();
		add(background);
		
		stage = "choosing";
		
		cross = new Cross(0, 0);
		hud = new HUD();
		model = new Model();
		
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);
		
		spawnEnemies();
		
		cardHolder = new CardHolder();
		add(cardHolder);		
		for (i in 0 ... 5) {
			cardHolder.addCard(new Card(0, 400, params.getRandomType()));
		}
		
		notEnoughAmmoText = new FlxText(0, 0, 0, "НЕДОСТАТОЧНО ПАТРОНОВ", 25);
		notEnoughAmmoText.font = "assets/fonts/10692.ttf";
		notEnoughAmmoText.visible = false;
		notEnoughAmmoText.screenCenter();
		add(notEnoughAmmoText);
		
		fleeBtn = new FlxButton(0, 18, "Пропустить ход", strife);
		fleeBtn.label.font = "assets/fonts/10692.ttf";
		fleeBtn.screenCenter(FlxAxes.X);
		add(fleeBtn);
		
		add(cross);
		
		hud.updateHud(model.getHealth(), model.getAmmo());
		add(hud);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		cross.active = (stage == "shooting");
		FlxG.mouse.visible = !cross.active;
		
		enemies.forEachDead(function(e) {
			remove(e.healthInfo);
			enemies.remove(e, true);
		});
		
		if (stage == "choosing" && enemies.members.length == 0)
		{
			if (wave == 4) {
				win();
			} else {
				goToNextWave();
			}
		}
		
		if (stage == "shooting") {
			cross.setPosition(FlxG.mouse.x - cross.width * 0.5, FlxG.mouse.y - cross.height * 0.5);
			enemies.forEach(function(e) {
				e.shake = true;
			});
			if (FlxG.mouse.justReleased && cardHolder.delay <= 0) {
				stage = "enemiesAttacking";
				enemiesAttackTimer = 150;
				FlxG.sound.play("assets/sounds/" + model.getCurrentAttack() + ".wav");
				enemies.forEach(function(e) {
					if (model.isAoe()) 
					{
						e.hurt(model.getDamage());
					}
					else if (FlxG.pixelPerfectOverlap(e, cross)) 
					{
						e.hurt(model.getDamage());
					}
				});
			}
		}
		else 
		{
			enemies.forEach(function(e) {
				e.shake = false;
			});
		}
		
		if (stage == "enemiesAttacking")
		{
			if (enemiesAttackTimer == 100 && enemies.members[0] != null && enemies.members[0].alive) {
				enemies.members[0].playAnimationShoot();
			}
			if (enemiesAttackTimer == 60 && enemies.members[1] != null && enemies.members[0].alive) {
				enemies.members[1].playAnimationShoot();
			}
			if (enemiesAttackTimer == 30 && enemies.members[2] != null && enemies.members[0].alive) {
				enemies.members[2].playAnimationShoot();
			}
			if (enemiesAttackTimer <= 0) {
				stage = "choosing";
				cardHolder.show();
				for (i in 0...cardsUsed) {
					addCard();
				}
				cardsUsed = 0;
				model.dropModel();
			}
		}
		
		if (enemiesAttackTimer > 0) {
			--enemiesAttackTimer;
		}
		
		if (model.getHealth() <= 0)
		{
			gameOver();
		}

		hud.updateHud(model.getHealth(), model.getAmmo());
		cross.update(elapsed);
		cardHolder.update(elapsed);
		super.update(elapsed);
	}
	
	private function gameOver()
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
		{
			FlxG.switchState(new GameoverState());
		});
	}
	
	private function win()
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
		{
			FlxG.switchState(new WinState());
		});
	}
	
	private function addCard() 
	{
		cardHolder.addCard(new Card(0, 400, params.getRandomType()));
	}
	
	private function strife()
	{
		stage = "enemiesAttacking";
		cardHolder.dropAllCards();
		for (i in 0...5) {
			addCard();
		}
		cardsUsed = 0;
		cardHolder.startDelay();
		enemiesAttackTimer = 100;
	}
	
	private function goToNextWave()
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
		{
			var toNextWaveState = new ToNextWaveSubState(wave);
			openSubState(toNextWaveState);
			spawnEnemies();
		});
	}
	
	private function spawnEnemies()
	{
		++wave;
		background.changeBack(wave);
		var Y = wave == 4 ? 262 : 190;
		for (i in 0 ... FlxG.random.int(2, 3))
		{
			if (i == 0) {
				enemies.add(new Enemy(FlxG.width * 0.5 - 325, Y, enemiesPool.getWaveType(wave)));
			}
			else if (i == 1) {
				enemies.add(new Enemy(FlxG.width * 0.5 + 50, Y, enemiesPool.getWaveType(wave)));
			}
			else if (i == 2) {
				enemies.add(new Enemy(FlxG.width * 0.5 - 125, Y + 20, enemiesPool.getWaveType(wave)));
			}
		}
		
		enemies.forEach(function(e) 
		{
			add(e.healthInfo);
		});
	}
}
