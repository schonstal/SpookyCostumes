package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxGradient;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;

class InfoGroup extends FlxSpriteGroup
{
  var infoBox:InfoBox;
  var hideTween:FlxTween;
  var showTween:FlxTween;

  public function new(Width:Int, Height:Int) {
    super();

    infoBox = new InfoBox(Width,Height);
    add(infoBox);
  }

  public function show():Void {
    if (hideTween != null) hideTween.cancel();
    showTween = FlxTween.tween(infoBox, { alpha: 0.9 }, 0.2, { ease: FlxEase.quartOut });
    visible = true;
  }

  public function hide():Void {
    if (showTween != null) showTween.cancel();
    hideTween = FlxTween.tween(infoBox, { alpha: 0 }, 0.2, { ease: FlxEase.quartOut, onComplete: function(t):Void {
      visible = false;
    }});
  }
}
