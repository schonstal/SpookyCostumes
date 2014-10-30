package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class CircleState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Skeleton Key"];
    flavorText = "As long as we keep everything inside the magic circle, we should be able to perform the conversions smoothly.";
    affordText = "We can't do the transmutation without all the ingredients.";
    maxText = "You can't transmute any more.";

    title = "The Werewolf Spire";

    super.create();
  }

  override private function purchaseCallback(itemName:String):Void {
    Reg.addItem(itemName);

    if (itemName == "Candleabra") {
      Reg.inventory.fame += 10;
    }
  }
}
