package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class ToNextWaveSubState extends FlxSubState 
{

	private var closeBtn:FlxButton;
	private var back:FlxSprite;
	
	public function new(wave:Int) 
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		super(FlxColor.BLACK);
		back = new FlxSprite();
		if (wave > 3) {
			wave = 3;
		}
		back.loadGraphic("assets/images/next_wave_" + Std.string(wave) + ".png");
		add(back);
		
		var textLabel:String = "";
		if (wave == 0) {
			textLabel = "Вы чувствуете прилив сил\nОткрыта карта \"Ярость\"";
		}
		if (wave == 1) {
			textLabel = "Вы нашли пистолет\nОткрыта карта \"Выстрел из пистолета\"";
		}
		if (wave == 2) {
			textLabel = "Вы нашли дробовик\nОткрыта карта \"Выстрел из дробовика\"";
		}
		if (wave == 3) {
			textLabel = "Вы нашли автомат\nОткрыта карта \"Очередь из автомата\"";
		}
		var text:FlxText = new FlxText(0, 0, 800, textLabel);
		text.setFormat("assets/fonts/10692.ttf", 25);
		text.alignment = FlxTextAlign.CENTER;
		text.y = 20;
		add(text);
		
		closeBtn = new FlxButton(0, 0, "Дальше", onClick);
		closeBtn.pixelPerfectRender = true;
		closeBtn.loadGraphic("assets/images/button_wider.png", true, 149, 42);
		closeBtn.label.setFormat("assets/fonts/10692.ttf", 23, 0x3B3B3B, FlxTextAlign.CENTER);
		closeBtn.screenCenter();
		closeBtn.y = 350;
		closeBtn.screenCenter();
		add(closeBtn);
		
	}
	
	private function onClick()
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		close();
	}
	
	public static function onSubstateClose():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
	}
	
	override public function update(elapsed:Float) {
		
		back.update(elapsed);
		super.update(elapsed);
	}
	
}