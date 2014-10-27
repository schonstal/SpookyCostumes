package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxGradient;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flash.display.BlendMode;

class NavGroup extends FlxSpriteGroup
{
  var blackBarSprite:FlxSprite;
  var bloodText:FlxText;
  var titleText:FlxText;
  var burger:FlxButton;

  public function new(name:String, enabled:Bool=true) {
    super();
    blackBarSprite = new FlxSprite();
    blackBarSprite.makeGraphic(FlxG.width, 60, 0xff000000);
    blackBarSprite.alpha = 0.55;
    blackBarSprite.blend = BlendMode.MULTIPLY;
    add(blackBarSprite);

    bloodText = new FlxText(70);
    bloodText.setFormat("assets/fonts/AmaticSC-Bold.ttf", 42, 0xff9f79b7, "left");
    add(bloodText);

    titleText = new FlxText(0,0,FlxG.width-20);
    titleText.setFormat("assets/fonts/AmaticSC-Bold.ttf", 42, 0xff9f79b7, "right");
    titleText.text = name;
    add(titleText);

    if(!enabled) {
      y = -60;
      blackBarSprite.alpha = 0;
      bloodText.alpha = titleText.alpha = 0;
    }
  }

  override public function update():Void {
    bloodText.text = "Blood: " + Math.floor(Reg.inventory.blood) + " ";

    if (Math.floor(Reg.inventory.influence) > 0) {
      bloodText.text += "Fame: " + Math.floor(Reg.inventory.influence);
    }
    super.update();

    bloodText.alpha = titleText.alpha;
  }

  public function enable():Void {
    FlxTween.tween(this, { y: 0 }, 0.3, { ease: FlxEase.quartOut });
    FlxTween.tween(blackBarSprite, { alpha: 0.55 }, 0.3, { ease: FlxEase.quartOut });
    FlxTween.tween(titleText, { alpha: 1 }, 0.3, { ease: FlxEase.quartOut });
  }
}
