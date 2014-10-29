package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class SpaceState extends FlxState
{
  var titleText:FlxText;
  var infoGroup:ItemInfoGroup;
  var dialog:DialogGroup;

  var dustButton:GradientButton;
  var width = 610;

  var height = 80;

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());

    dialog = new DialogGroup();
    dialog.text = "Woah! You just used the Space Key to unlock the moon! I didn't even know that was possible!";
    add(dialog);
    
    dustButton = new GradientButton(170, 195, width, height, "Harvest Moon Dust", new ItemInfoGroup("Moon Dust"));
    dustButton.onUp.callback = function():Void {
      var item:Dynamic = Reg.item("Moon Dust");
      if (!Math.isNaN(item.max) && item.max <= Reg.itemHeld("Moon Dust")) {
        dialog.text = "You have as much Moon Dust as you can carry.";
        return;
      }
      dialog.text = item.purchaseText;
      Reg.addItem("Moon Dust");
    }
    add(dustButton);

    FlxG.camera.antialiasing = true;

    add(dustButton.infoGroup);
    add(new NavGroup("The Moon"));
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    var item = Reg.item("Moon Dust");
    if (!Math.isNaN(item.max) && item.max <= Reg.itemHeld("Moon Dust")) {
      if(dustButton.enabled) dustButton.disable();
    } else {
      if(!dustButton.enabled) dustButton.enable();
    }
    super.update();
    Resources.update();
  }
}
