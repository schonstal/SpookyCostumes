package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class ShopState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Candle", "Pumpkin"];
    flavorText = "I've got a lot of stuff on sale for Halloween. Take a look!";
    affordText = "You can't afford that right now.";
    maxText = "Sorry, I'm sold out.";

    if (Reg.itemHeld("Beguiler") < 10) availableItems.push("Beguiler");
    if (!Reg.unlocks.basement) availableItems.push("Basement Key");
    if (!Reg.unlocks.cauldron) availableItems.push("Cauldron");

    title = "Vampyre Shoppe";

    columns = 2;

    Reg.unlockLocation("Shoppe");

    super.create();
  }

  override private function purchaseCallback(itemName:String):Void {
    Reg.addItem(itemName);

    if (itemName == "Basement Key") {
      Reg.unlocks.basement = true;
    }
    if (itemName == "Cauldron") {
      Reg.unlocks.cauldron = true;
    }
  }
}
