package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class DrinkState extends FlxState
{
  var sinAmt:Float = 0;
  var marcelene:FlxSprite;
  var outsideText:FlxText;

  var bloodButton:GradientButton;
  var candyButton:GradientButton;
  var shopButton:GradientButton;

  var nav:NavGroup;

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());

    outsideText = new FlxText(0,100,FlxG.width,FlxG.height);
    outsideText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 90, 0xffeadbf4, "center");
    add(outsideText);

    candyButton = new GradientButton(FlxG.width/2 + 10, 480, 300, 100, "Treat");
    candyButton.onUp.callback = Resources.harvestInfluence;
    add(candyButton);

/*
    shopButton = new GradientButton(FlxG.width/2 - 310, 530, 620, 100, "Return to your Lair");
    shopButton.onUp.callback = function():Void {
      Transition.to(new LairState());
    }
    shopButton.exists = false;
    add(shopButton);
*/

    nav = new NavGroup("Front Door", Reg.unlocks.menu);

    bloodButton = new GradientButton(FlxG.width/2 - 310, 480, 300, 100, "Trick");
    bloodButton.onUp.callback = function():Void {
      Resources.harvestBlood();
      if (!Reg.unlocks.menu) {
        nav.enable();
        Reg.unlocks.menu = true;
      }
    }
    add(bloodButton);

    FlxG.mouse.useSystemCursor = true;
    FlxG.camera.antialiasing = true;

    add(nav);
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    outsideText.text = "Outside, there are\n" +
                       Math.floor(Reg.inventory.kids) + "\n" +
                       "kids in spooky costumes";

    super.update();

    Resources.update();
  }
}
