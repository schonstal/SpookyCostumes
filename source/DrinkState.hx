package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class DrinkState extends FlxState
{
  var sinAmt:Float = 0;
  var marcelene:FlxSprite;
  var outsideText:FlxText;

  var bloodButton:GradientButton;
  var candyButton:GradientButton;
  var shopButton:GradientButton;

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());
    add(new BloodText());

    outsideText = new FlxText(0,30,FlxG.width,FlxG.height);
    outsideText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 90, 0xffffffff, "center");
    add(outsideText);

    bloodButton = new GradientButton(FlxG.width/2 - 310, 410, 300, 100, "Trick");
    bloodButton.onUp.callback = Resources.harvestBlood;
    add(bloodButton);

    candyButton = new GradientButton(FlxG.width/2 + 10, 410, 300, 100, "Treat");
    candyButton.onUp.callback = Resources.harvestInfluence;
    add(candyButton);

    shopButton = new GradientButton(FlxG.width/2 - 310, 530, 620, 100, "Return to your Lair");
    shopButton.onUp.callback = function():Void {
      Transition.to(new LairState());
    }
    add(shopButton);

    FlxG.camera.antialiasing = true;
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
