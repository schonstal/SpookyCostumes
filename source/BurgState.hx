package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class BurgState extends LocationState
{
  override public function create():Void {
    title = "Haunted Burg";
    locations = ["Shop", "Shoppe"];
    if (Reg.unlocks.basement) locations.push("Basement");
    if (Reg.unlocks.scrying) locations.push("Scrying Pool");
    if (Reg.unlocks.cauldron) locations.push("Cauldron");

    super.create();
  }
}
