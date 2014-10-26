package;
import flixel.FlxState;
import flixel.FlxG;

//Just fades for now, but want a nice transition
class Transition {
  public static function to(state:FlxState):Void {
    FlxG.camera.fade(0xff000000, 0.3, false, function():Void {
      Reg.save.flush();
      FlxG.switchState(state);
    });
  }

  public static function finish():Void {
    FlxG.camera.flash(0xff000000, 0.3);
  }
}
