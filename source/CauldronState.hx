package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class CauldronState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Rite of The Hallow", "Rite of Blood", "Rite of Majesty"];
    flavorText = "With this we will finally be able control the Spirit of Halloween, " +
                 "bring eternal nightfall upon the world and reign in this eventide kingdom for the rest of time!";

    purchaseText = "Lose yourself to danse.";
    affordText = "You don't have the components needed to perform this ritual.";
    maxText = "You can't perform this ritual right now.";

    title = "Witch Queen's Cauldron";

    super.create();
  }
}
