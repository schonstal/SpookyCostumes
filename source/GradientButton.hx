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
class GradientButton extends FlxButton
{
  var spriteFilter:FlxSpriteFilter;
  var glowFilter:GlowFilter;
  var blurTween:FlxTween;

  public function new(X:Float, Y:Float, Width:Int, Height:Int, text:String) {
    super(X+35, Y+35, text);
    var gradient = FlxGradient.createGradientFlxSprite(Width*3, Height, [0xff170e35, 0xff49245d]);
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


    loadGraphic(this.pixels, true, Width, Height);

    label.setFormat("assets/fonts/AmaticSC-Regular.ttf", Height * 0.6, 0xffffffff, "center");
    labelOffsets = [FlxPoint.get(-35, Height * 0.075), FlxPoint.get(-35, Height * 0.075), FlxPoint.get(-35, Height * 0.075 + 1)];
    labelAlphas = [1, 1, 0.5];
    label.alpha = 1;

    glowFilter = new GlowFilter(0xffe9a56d, 1, 10, 10, 1, 1);
    
    spriteFilter = new FlxSpriteFilter(this, 70, 70);
    spriteFilter.addFilter(glowFilter);

    blurTween = FlxTween.tween(glowFilter, { blurX: 20, blurY: 20 }, 1, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut });
    
    onOver.callback = startHover;
    onOut.callback = endHover;

    endHover();
    
    width = Width;
    height = Height;
    offset.x = offset.y = 35;

    alpha = 0.8;
  }

  override public function update():Void {
    super.update();
    spriteFilter.applyFilters();
  }

  private function endHover():Void {
    blurTween.active = false;
    glowFilter.blurX = glowFilter.blurY = 0;
    label.color = 0xffffffff;
    alpha = 0.8;
  }

  private function startHover():Void {
    blurTween.active = true;
    glowFilter.blurX = glowFilter.blurY = 10;
    label.color = 0xffe9a56d;
    alpha = 1;
  }
}
