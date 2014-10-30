package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class BoneyardState extends LocationState
{
  override public function create():Void {
    title = "Boneyard";
    locations = ["Tombstone", "Tombstone", "Tombstone", "Tombstone", "Tombstone"];
    super.create();
  }
}
