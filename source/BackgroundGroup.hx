package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class BackgroundGroup extends FlxSpriteGroup
{
  static var SPACE_X = 200;
  static var SPACE_Y = 100;
  static var SPRITES = ["bat", "skull", "coffin", "skull"];

  public function new() {
    super();
    for (j in (0...12)) {
      for (i in (0...8)) {
        var bat = new FlxSprite((j % 2 == 0 ? -SPACE_X/2 : 0) + (i * SPACE_X),
                                (j-1) * SPACE_Y);
        bat.loadGraphic("assets/images/" +
                          (i % 2 == (j % 4 == 0 ? 1 : 0) ? "skull" : SPRITES[j%4]) +
                          ".png");
        add(bat);
      }
    }
  }

  override public function update():Void {
    for (sprite in members) {
      sprite.x -= 20 * FlxG.elapsed;
      sprite.y += 20 * FlxG.elapsed;
    }
    super.update();
    for (sprite in members) {
      if (sprite.y >= 10 * SPACE_Y) {
        sprite.y = -2*SPACE_Y;
      }
      if (sprite.x + sprite.width <= 0) {
        sprite.x = FlxG.width + (sprite.x + sprite.width) + SPACE_X;
      }
    }
  }
}
