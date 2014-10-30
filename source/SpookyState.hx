package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class SpookyState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Candle Box", "Pumpkin Box", "Bone Shard", "Bone Hammer", "Harvester"];
    flavorText = "It's a Halloween sale! What'll ya have?";
    affordText = "You don't have enough blood to buy that.";
    maxText = "Sorry, I'm sold out.";

    if (!Reg.unlocks.library) availableItems.push("Library Card");

    title = "Spooky Shoppe";

    columns = 2;

    super.create();
  }

  override private function purchaseCallback(itemName:String):Void {
    Reg.addItem(itemName);

    if (itemName == "Pumpkin Box") {
      Reg.addItem("Pumpkin", 100);
    }

    if (itemName == "Candle Box") {
      Reg.addItem("Candle", 100);
    }

    if (itemName == "Library Card") {
      Reg.unlocks.library = true;
    }
    if (itemName == "Harvester") {
      Reg.unlocks.harvester = true;
    }
  }
}
