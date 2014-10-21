package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxGradient;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
  override public function create():Void {
    super.create();
    FlxG.mouse.useSystemCursor = true;
    add(FlxGradient.createGradientFlxSprite(FlxG.width,
                                            FlxG.height,
                                            [0xff43277c, 0xff130b22]));
    add(new BackgroundGroup());
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
  }
}
