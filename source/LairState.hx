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

    doorButton = new GradientButton(FlxG.width/2 - 310, 100, 620, 100, "Front Door");
    doorButton.onUp.callback = function() {
      Transition.to(new DrinkState());
    };
    add(doorButton);

    shopButton = new GradientButton(FlxG.width/2 - 310, 220, 620, 100, "Vampyre Shoppe");
    shopButton.onUp.callback = function():Void {
      Transition.to(new ShopState());
    }
    add(shopButton);

    add(new NavGroup("Lair"));

    FlxG.camera.antialiasing = true;
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
    doorButton.text = "Front Door (" + Math.floor(Reg.inventory.kids) + ")";
    Resources.update();
  }
}
