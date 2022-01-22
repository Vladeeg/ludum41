package;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;

class CardHolder extends FlxTypedGroup<Card>
{
	var vOffset: Float;
	
	public var delay:Int;
	private var canClick:Bool;
	private var canHover:Bool;
	private var notEnoughAmmoTimer:Int;
	
	public function new() 
	{
		vOffset = FlxG.height * 0.5;
		super();
		canHover = true;
		FlxMouseEventManager.init();
	}
	
	public function addCard(card:Card)
	{
		var segmentation = members.length > 0 ? (FlxG.width - Card.WIDTH) / members.length : FlxG.width * 0.5;
		add(card);
		FlxMouseEventManager.add(card, onMouseDown, onMouseUp, onMouseIn, onMouseOut);
		for (i in 0 ... members.length)
		{
			members[i].x = segmentation * i;
			//FlxTween.tween(members[i], {x: segmentation * i}, 0.5);
		}
		forEach(function(c)
		{
			var pos = c.x - (FlxG.width - Card.WIDTH) * 0.5;
			//c.angle = pos * Math.PI / 80;
			FlxTween.angle(c, c.angle, pos * Math.PI / 80, 0.2);
			// c.y = (2 * FlxG.width) / 16 + pos * pos / (2 * FlxG.width);
			// FlxTween.tween(card, {y: 400 + Math.sqrt(Math.abs(pos)) * 2}, 0.5);
			FlxTween.tween(card, {y: vOffset + (2 * FlxG.width) / 16 + pos * pos / (2 * FlxG.width)}, 0.5);
			//card.y= 400 + Math.sqrt(Math.abs(pos)) * 2;
		});
	}
	
	private function onMouseIn(card:Card)
	{
		if (canHover) {
			FlxTween.tween(card, {y: 320}, 0.1);
			//card.y = 350;
			canClick = true;
		}
	}
	
	private function onMouseOut(card:Card)
	{
		var pos = card.x - (FlxG.width - Card.WIDTH) * 0.5;
		// FlxTween.tween(card, {y: 400 + Math.sqrt(Math.abs(pos)) * 2}, 0.1);
		FlxTween.tween(card, {y: vOffset + (2 * FlxG.width) / 16 + pos * pos / (2 * FlxG.width)}, 0.1);
		//card.y = 400 + Math.sqrt(Math.abs(pos)) * 2;
	}
	
	private function onMouseDown(card:Card)
	{
		
	}
	
	private function onMouseUp(card:Card)
	{
		if (canClick && card.getCost() <= PlayState.model.getAmmo()) {
			PlayState.cardsUsed++;
			PlayState.model.reduceAmmo(card.getCost());
			removeCard(card);
			PlayState.model.addDamage(card.getDmg(), card.type == "shotgun");
			PlayState.model.setCurrentAttack(card.type);
			if (card.getDmg() > 0 && card.type != "rage") {
				PlayState.stage = "shooting";
				delay = 10;
				hide();
			} else {
				FlxG.sound.play("assets/sounds/" + card.type + ".wav");
			}
			if (card.type == "heal") {
				PlayState.model.addHealth(4);
			}
		}
		else
		{
			notEnoughAmmoTimer = 100;
		}
	}
	
	public function dropAllCards() {
		while (members.length > 0) {
			if (members[0] != null) {
				removeCard(members[0]);
			}
		}
	}
	
	public function startDelay()
	{
		delay = 10;
	}
	
	public function hide()
	{
		active = false;
		canHover = false;
		forEach(function(c)
		{
			FlxTween.tween(c, {y: 900}, 0.5);
			//c.y = 900;
		});
	}
	
	public function show()
	{
		active = true;
		canHover = true;
		var segmentation = members.length > 1 ? (FlxG.width - Card.WIDTH) / (members.length - 1) : FlxG.width * 0.5;
		for (i in 0 ... members.length)
		{ members[i].x = segmentation * i; }
		forEach(function(c)
		{
			var pos = c.x - (FlxG.width - Card.WIDTH) * 0.5;
			c.angle = pos * Math.PI / 80;
			//c.y = 400 + Math.sqrt(Math.abs(pos)) * 2;
			// FlxTween.tween(c, {y: 400 + Math.sqrt(Math.abs(pos)) * 2}, 0.5);
			FlxTween.tween(c, {y: vOffset + (2 * FlxG.width) / 16 + pos * pos / (2 * FlxG.width)}, 0.5);
		});
	}
	
	public function removeCard(card:Card)
	{
		remove(card, true);
		card.kill();
		var segmentation = members.length > 1 ? (FlxG.width - Card.WIDTH) / (members.length - 1) : FlxG.width * 0.5;
		for (i in 0 ... members.length)
		{ members[i].x = segmentation * i; }
		forEach(function(c)
		{
			var pos = c.x - (FlxG.width - Card.WIDTH) * 0.5;
			c.angle = pos * Math.PI / 80;
			// c.y = 400 + Math.sqrt(Math.abs(pos)) * 2;
			c.y = vOffset + (2 * FlxG.width) / 16 + pos * pos / (2 * FlxG.width);
		});
	}
	
	override public function update(elapsed:Float)
	{
		if (delay > 0) {
			--delay;
		}
		
		if (notEnoughAmmoTimer > 0)
		{
			--notEnoughAmmoTimer;
			PlayState.notEnoughAmmoText.visible = true;
		}
		else {
			PlayState.notEnoughAmmoText.visible = false;
		}
			
		super.update(elapsed);
	}
	
}