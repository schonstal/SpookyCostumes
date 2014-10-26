package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxGradient;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;
import flash.filters.GlowFilter;
import flixel.effects.FlxSpriteFilter;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

/**
 * A FlxState which can be used for the game's menu.
 */
class DialogBox extends FlxSprite
{
  public function new(X:Float=100, Y:Float=430, Width:Int=1080, Height:Int=260) {
    super(X, Y);
    var gradient = FlxGradient.createGradientFlxSprite(Width, Height, [0xff150c25, 0xff412679]);
    loadGraphic(gradient.pixels);//, true, Width, Height);

    FlxSpriteUtil.drawRoundRect(this, 5, 5, Width-10, Height-10, 10, 10, 0x00000000, { thickness: 5, color: 0xffdfd7ed }, { smoothing: false });

    var alphaSprite = new FlxSprite();
    alphaSprite.makeGraphic(Width, Height, 0x00000000);

    FlxSpriteUtil.drawRoundRect(alphaSprite, 5, 5, Width-10, Height-10, 10, 10, 0xff000000, { thickness: 5, color: 0xff000000 }, { smoothing: false });

    FlxSpriteUtil.alphaMaskFlxSprite(this, alphaSprite, this);

    loadGraphic(this.pixels, true, Width, Height);

    alpha = 0.8;
  }
}
