package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class HarvestState extends GenericShopState
{
  override public function create():Void {
    availableItems = ["Destroy Harvester"];
    flavorText = "This thing is sucking blood like crazy! Let me know if you think we should destroy it.";

    title = "Harvester";

    super.create();
  }
}
