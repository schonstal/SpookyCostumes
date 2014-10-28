package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxGradient;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;

class DialogGroup extends FlxSpriteGroup
{
  var dialogBox:DialogBox;
  var dialogText:FlxText;

  public function new(X:Float=100, Y:Float=430, Width:Int=1080, Height:Int=260) {
    super();

    dialogBox = new DialogBox(X, Y, Width, Height);
    add(dialogBox);

    dialogText = new FlxText(X+30, Y+15, Width-80);
    dialogText.setFormat("assets/fonts/RobotoSlab-Thin.ttf", 42, 0xffeadbf4, "left");
    add(dialogText);
  }

  public var text(get, set):String;

  public function set_text(t:String):String {
    dialogText.text = t;
    return t;
  }

  public function get_text():String {
    return dialogText.text;
  }
}
