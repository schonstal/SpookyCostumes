package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class CauldronState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Rite of The Hallow", "Rite of Majesty", "Rite of Blood"];
    flavorText = "With this we will finally be able control the Spirit of Halloween, " +
                 "bring eternal nightfall upon the world and reign in this eventide kingdom for the rest of time!";

    purchaseText = "Lose yourself to danse.";
    affordText = "You don't have the components needed to perform this ritual.";
    maxText = "You can't perform this ritual right now.";

    title = "Witch Queen's Cauldron";

    Reg.unlockLocation("Cauldron");
    super.create();
  }

  override private function purchaseCallback(itemName:String):Void {
    Reg.addItem(itemName);
    if (itemName == "Rite of The Hallow") {
      FlxG.camera.shake(0.01, 0.3);
      Transition.to(new WinState());
    }
  }
}
