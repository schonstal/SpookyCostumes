package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class LairState extends LocationState
{
  override public function create():Void {
    title = "Lair";
    locations = ["Door", "Shoppe"];
    if (Reg.unlocks.basement) locations.push("Basement");
    if (Reg.unlocks.scrying) locations.push("Pool");
    if (Reg.unlocks.cauldron) locations.push("Cauldron");

    super.create();
  }

  override public function update():Void {
    super.update();
    buttons[0].text = "Front Door (" + Math.floor(Reg.inventory.kids) + ")";
  }
}
