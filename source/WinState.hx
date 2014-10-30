package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class WinState extends GenericShopState
{
  var state:Int = 0;

  override public function create():Void {
    availableItems = ["Moon Dust"];
    flavorText = "Ahahahahaha! You fool!";
    showHovers = false;

    title = "The Dark Ritual";

    super.create();
  }

  override private function purchaseCallback(itemName:String):Void {
    if (state >= 8) {
      Transition.to(new GameOverState());
      dialog.text = "";
      return;
    }
    dialog.text = ["Ahahahahaha! You fool!",
                   "Did you really think you would defeat me?",
                   "The true spirit of Halloween cannot be controlled!",
                   "But you--and your considerable power--can be.",
                   "You released this plague upon the world!",
                   "You gave me the power that I need!",
                   "And now I will reign supreme!",
                   "Ahahahahahahaha!",
                   "Sleep! Return to your eternal slumber!",
                   ""][++state];
  }

  override private function buttonTitle(itemName):String {
    return "Next";
  }

  override public function update():Void {
    FlxG.camera.shake(0.005, 0.3);
    super.update();
  }
}
