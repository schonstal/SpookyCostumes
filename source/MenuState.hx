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
  var blood = 0;
  var bloodText:FlxText;

  var sinAmt:Float = 0;
  var marcelene:FlxSprite;

  override public function create():Void {
    super.create();
    FlxG.mouse.useSystemCursor = true;
    add(FlxGradient.createGradientFlxSprite(FlxG.width,
                                            FlxG.height,
                                            [0xff43277c, 0xff130b22]));
    add(new BackgroundGroup());

    bloodText = new FlxText();
    add(bloodText);

    marcelene = new FlxSprite();
    marcelene.loadGraphic("assets/images/marcelene.png");
    marcelene.x = FlxG.width/2 - marcelene.width/2;
    marcelene.y = 10;
    add(marcelene);

    FlxG.camera.antialiasing = true;
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    if (FlxG.mouse.justPressed) {
      blood++;
    }
    if(blood > 0) bloodText.text = "Blood: " + blood;
    super.update();

    sinAmt += FlxG.elapsed;
    marcelene.offset.y = 10 * Math.sin(sinAmt);

  }
}
