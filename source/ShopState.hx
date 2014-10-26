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

    titleText = new FlxText(0,30,FlxG.width,FlxG.height);
    titleText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 90, 0xffffffff, "center");
    titleText.text = "Vampyre Shoppe";
    add(titleText);

    var shopButton:GradientButton;
    //Make this a dynamic later? Or maybe have a class for an object.
    var availableItems:Array<String> = ["Candle", "Pumpkin", "Butt", "Stink", "Diamond", "JoJo", "Uhg", "Candy Bar", "A Thing"];
    
    var i:Int = 0;
    for (item in availableItems) {
      var width = 200;
      var height = 100;
      shopButton = new GradientButton(FlxG.width/2 - (i%3 * width/2), 100 + Math.floor(i/3) * (height + 20), width, height, item);
      shopButton.onUp.callback = function():Void {
        Transition.to(new LairState());
      }
      add(shopButton);
      i++;
    }

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
