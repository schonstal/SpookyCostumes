package;

import flixel.FlxG;
import flixel.FlxSprite;

class Cursor extends FlxSprite
{
  public function new() {
    super();
    loadGraphic("assets/images/cursor.png");
  }

  override public function update():Void {
    x = FlxG.mouse.x;
    y = FlxG.mouse.y;
    super.update();
  }
}
