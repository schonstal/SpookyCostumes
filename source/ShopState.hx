package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class ShopState extends FlxState
{
  var titleText:FlxText;

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());
    add(new BloodText());

    var shopButton:GradientButton;
    //Make this a dynamic later? Or maybe have a class for an object.
    var availableItems:Array<String> = ["Candle", "Pumpkin"];//, "Butt", "Stink", "Diamond", "JoJo", "Uhg", "Candy Bar", "A Thing"];
    
    var i:Int = 0;
    for (item in availableItems) {
      var width = 250;
      var height = 100;
      shopButton = new GradientButton(120 + (i%3 * (width + 10)), 90 + Math.floor(i/3) * (height + 10), width, height, item);
      shopButton.onUp.callback = function():Void {
        Transition.to(new LairState());
      }
      add(shopButton);
      i++;
    }

    FlxG.camera.antialiasing = true;

    add(new DialogBox(100, 430));
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
    Resources.update();
  }
}
