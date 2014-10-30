package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class BoneyardState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Ancient Relic"];
    flavorText = "Woah! It's the ~ancient relic~!";

    title = "Ancient Boneyard";

    super.create();
  }

  override private function buttonTitle(itemName):String {
    return "Take the Ancient Relic";
  }
}
