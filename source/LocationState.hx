package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class LocationState extends FlxState
{
  var locations:Array<String> = [];
  var buttons:Array<GradientButton> = [];

  var title:String = "A Mysterious Place";

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());

    var i:Int = 0;
    for (locationName in locations) {
      var location = Reg.location(locationName);
      var locationButton:GradientButton = new GradientButton(FlxG.width/2 - 310, 100 + 120 * i, 620, 100, location.longName);
      locationButton.onUp.callback = function() {
        Transition.to(Type.createInstance(location.state, []));
      };
      add(locationButton);
      buttons.push(locationButton);
      i++;
    }

    add(new NavGroup(title));

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
