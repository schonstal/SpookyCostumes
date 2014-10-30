package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class SpaceState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Moon Dust"];
    flavorText = "Woah! You just used the Space Key to unlock the moon! I didn't even know that was possible!";

    maxText = "You have as much Moon Dust as you can carry.";

    title = "The Moon";

    super.create();
  }

  override private function buttonTitle(itemName):String {
    return "Harvest Moon Dust";
  }
}
