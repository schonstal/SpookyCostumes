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
  var basementButton:GradientButton;
  var cauldronButton:GradientButton;

  override public function create():Void {
    super.create();
    Transition.finish();
    Reg.unlockLocation("Door");

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

    if (Reg.unlocks.basement) {
      basementButton = new GradientButton(FlxG.width/2 - 310, 340, 620, 100, "Basement");
      basementButton.onUp.callback = function():Void {
        Transition.to(new BasementState());
      }
      add(basementButton);
    }

    if (Reg.unlocks.cauldron) {
      cauldronButton = new GradientButton(FlxG.width/2 - 310, 460, 620, 100, "Witch Queen's Cauldron");
      cauldronButton.onUp.callback = function():Void {
        Transition.to(new CauldronState());
      }
      add(cauldronButton);
    }

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
