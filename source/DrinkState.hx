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

  override public function create():Void {
    super.create();

    add(new BackgroundGroup());
    add(new BloodText());

    marcelene = new FlxSprite();
    marcelene.loadGraphic("assets/images/test.png");
    marcelene.x = FlxG.width/2 - marcelene.width/2;
    marcelene.y = 10;
    //add(marcelene);

    outsideText = new FlxText(0,30,FlxG.width,FlxG.height);
    outsideText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 90, 0xffffffff, "center");
    add(outsideText);

    bloodButton = new GradientButton(FlxG.width/2 - 310, 410, 300, 100, "Trick");
    bloodButton.onUp.callback = Resources.harvestBlood;
    add(bloodButton);

    candyButton = new GradientButton(FlxG.width/2 + 10, 410, 300, 100, "Treat");
    candyButton.onUp.callback = Resources.harvestInfluence;
    add(candyButton);

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

    sinAmt += FlxG.elapsed;
    //marcelene.offset.y = 10 * Math.sin(sinAmt);

    Resources.update();
  }
}
