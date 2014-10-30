package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class ShopState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Candle", "Pumpkin", "Beguiler"];
    flavorText = "I've got a lot of stuff on sale for Halloween. Take a look!";
    affordText = "You don't have enough blood to buy that.";
    maxText = "Sorry, I'm sold out.";

    if (!Reg.unlocks.basement) availableItems.push("Basement Key");
    if (!Reg.unlocks.cauldron) availableItems.push("Cauldron");

    title = "Vampyre Shoppe";

    columns = 2;

    super.create();
  }

  override private function purchaseCallback(itemName:String):Void {
    if (itemName == "Basement Key") {
      Reg.unlocks.basement = true;
    }
    if (itemName == "Cauldron") {
      Reg.unlocks.cauldron = true;
    }
  }
}
