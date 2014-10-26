package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxGradient;

class BackgroundGroup extends FlxSpriteGroup
{
  public function new() {
    super();
    add(FlxGradient.createGradientFlxSprite(FlxG.width,
                                            FlxG.height,
                                            [0xff43277c, 0xff130b22]));
    add(new ScrollingBackground());
  }
}
