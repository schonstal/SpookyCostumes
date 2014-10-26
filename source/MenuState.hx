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
  var bloodText:FlxText;

  var sinAmt:Float = 0;
  var marcelene:FlxSprite;


  override public function create():Void {
    super.create();

    add(FlxGradient.createGradientFlxSprite(FlxG.width,
                                            FlxG.height,
                                            [0xff43277c, 0xff130b22]));
    add(new BackgroundGroup());

    bloodText = new FlxText();
    bloodText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 64, 0xffffffff, "left");
    add(bloodText);

    marcelene = new FlxSprite();
    marcelene.loadGraphic("assets/images/test.png");
    marcelene.x = FlxG.width/2 - marcelene.width/2;
    marcelene.y = 10;
    //add(marcelene);

    add(new GradientButton(100, 300, 300, 100, "Drink Blood"));
    add(new GradientButton(420, 300, 300, 100, "Give Candy"));

    FlxG.camera.antialiasing = true;
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    if (FlxG.mouse.justPressed) {
      Reg.inventory.blood++;
    }
    if(Reg.inventory.blood > 0) bloodText.text = "Blood: " + Reg.inventory.blood;
    super.update();

    sinAmt += FlxG.elapsed;
    //marcelene.offset.y = 10 * Math.sin(sinAmt);

  }
}
