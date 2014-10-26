package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxGradient;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;

/**
 * A FlxState which can be used for the game's menu.
 */
class GradientButton extends FlxButton
{
  public function new(X:Float, Y:Float, Width:Int, Height:Int, text:String) {
    super(X, Y, text);
    var gradient = FlxGradient.createGradientFlxSprite(Width*3, Height, [0xff130b22, 0xff43277c]);
    loadGraphic(gradient.pixels);//, true, Width, Height);

    FlxSpriteUtil.drawRoundRect(this, 5, 5, Width-10, Height-10, 10, 10, 0x00000000, { thickness: 5, color: 0xffffffff }, { smoothing: false });
    FlxSpriteUtil.drawRoundRect(this, Width + 5, 5, Width-10, Height-10, 10, 10, 0x00000000, { thickness: 5, color: 0xffe9a56d }, { smoothing: false });
    FlxSpriteUtil.drawRoundRect(this, (2 * Width) + 5, 5, Width-10, Height-10, 10, 10, 0x00000000, { thickness: 5, color: 0xff333333 }, { smoothing: false });

    var alphaSprite = new FlxSprite();
    var alphaStamp = new FlxSprite();
    alphaSprite.makeGraphic(Width*3, Height, 0x00000000);
    alphaStamp.makeGraphic(Width, Height, 0x00000000);

    FlxSpriteUtil.drawRoundRect(alphaStamp, 5, 5, Width-10, Height-10, 10, 10, 0xff000000, { thickness: 5, color: 0xff000000 }, { smoothing: false });

    for (i in 0...3) {
      alphaSprite.stamp(alphaStamp, Width*i);
    }

    FlxSpriteUtil.alphaMaskFlxSprite(this, alphaSprite, this);

    //alpha = 0.8;

    loadGraphic(this.pixels, true, Width, Height);

    label.setFormat("assets/fonts/AmaticSC-Regular.ttf", Height * 0.6, 0xffffffff, "center");
    labelOffsets = [FlxPoint.get(0, Height * 0.075), FlxPoint.get(0, Height * 0.075), FlxPoint.get(0, Height * 0.075 + 1)];
  }
}
