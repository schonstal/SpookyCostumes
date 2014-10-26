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
class InfoBox extends FlxSprite
{
  public function new(Width:Int=1080, Height:Int=260) {
    super(0, 0);
    var gradient = FlxGradient.createGradientFlxSprite(Width, Height, [0xff170e35, 0xff49245d]);
    loadGraphic(gradient.pixels);//, true, Width, Height);

    FlxSpriteUtil.drawRoundRect(this, 5, 5, Width-10, Height-10, 10, 10, 0x00000000, { thickness: 5, color: 0xffdfd7ed }, { smoothing: false });

    var alphaSprite = new FlxSprite();
    alphaSprite.makeGraphic(Width, Height, 0x00000000);

    FlxSpriteUtil.drawRoundRect(alphaSprite, 5, 5, Width-10, Height-10, 10, 10, 0xff000000, { thickness: 5, color: 0xff000000 }, { smoothing: false });

    FlxSpriteUtil.alphaMaskFlxSprite(this, alphaSprite, this);

    alpha = 0.9;
  }
}
