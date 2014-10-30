package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class GameOverState extends FlxState
{
  var sinAmt:Float = 0;
  var marcelene:FlxSprite;
  var outsideText:FlxText;

  var bloodButton:GradientButton;
  var candyButton:GradientButton;
  var shopButton:GradientButton;

  var nav:NavGroup;

  override public function create():Void {
    super.create();
    Transition.finish();

    outsideText = new FlxText(0,200,FlxG.width,FlxG.height);
    outsideText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 90, 0xffeadbf4, "center");
    outsideText.text = "Game Over";
    add(outsideText);

    shopButton = new GradientButton(FlxG.width/2 - 310, 430, 620, 100, "New Game+");
    shopButton.onUp.callback = function():Void {
      Reg.reset();
      Transition.to(new DrinkState());
    }
    add(shopButton);
    FlxG.camera.antialiasing = true;
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
    Resources.update();
  }
}
