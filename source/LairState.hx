package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class LairState extends FlxState
{
  var titleText:FlxText;

  var doorButton:GradientButton;
  var shopButton:GradientButton;

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());
    add(new BloodText());

    titleText = new FlxText(0,30,FlxG.width,FlxG.height);
    titleText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 90, 0xffffffff, "center");
    titleText.text = "lair";
    add(titleText);

    doorButton = new GradientButton(FlxG.width/2 - 310, 200, 620, 100, "Front Door");
    doorButton.onUp.callback = function() {
      Transition.to(new DrinkState());
    };
    add(doorButton);

    shopButton = new GradientButton(FlxG.width/2 - 310, 320, 620, 100, "Vampyre Shoppe");
    shopButton.onUp.callback = function():Void {
      Transition.to(new ShopState());
    }
    add(shopButton);

    FlxG.camera.antialiasing = true;
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
    Resources.update();
  }
}
