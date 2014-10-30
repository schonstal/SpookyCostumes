package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class ScryState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Ancient Boneyard", "Darkwood Forest", "Haunted Burg"];

    flavorText = "From here you can dispatch your thralls, after which you'll be able to act through them as a surrogate.";
    affordText = "You don't have quite what it takes to go there yet.";
    maxText = "You've already assigned a thrall to this location.";

    if (!Reg.unlocks.basement) availableItems.push("Basement Key");
    if (!Reg.unlocks.cauldron) availableItems.push("Cauldron");

    title = "Scrying Pool";

    super.create();
  }

  override private function purchaseCallback(itemName:String):Void {
    Reg.unlockLocation(itemName.split(" ")[1]);
  }
}
