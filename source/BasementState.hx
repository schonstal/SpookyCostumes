package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class BasementState extends FlxState
{
  var dialog:DialogGroup;

  var shopButton:GradientButton;
  var unlockedScrying:Bool = false;

  override public function create():Void {
    super.create();
    Transition.finish();
    Reg.unlockLocation("Basement");

    add(new BackgroundGroup());

    dialog = new DialogGroup();
    add(dialog);

    if (Reg.inventory.Pumpkin >= 1 && Reg.inventory.Candle >= 1) {
      dialog.text = "Oh, you have just what I need! I could make you a lovely Jack-O-Lantern, if you like.";
    
      var width = 610;
      var height = 120;
      shopButton = new GradientButton(170, 115, width, height, "Carve Pumpkin", new ItemInfoGroup("Jack-O-Lantern"));
      shopButton.onUp.callback = function():Void {
        if (Reg.inventory.Pumpkin >= 1 && Reg.inventory.Candle >= 1) {
          Reg.inventory.Pumpkin--;
          Reg.inventory.Candle--;
          Reg.addItem("Jack-O-Lantern");
          if(Reg.itemHeld("Jack-O-Lantern") >= 10 && !Reg.unlocks.scrying) {
            unlockedScrying = true;
            Reg.unlocks.scrying = true;
          }
          dialog.text = "Here's a Jack-O-Lantern!";
          Reg.inventory.fame++;
        } else {
          dialog.text = "I can't make any more Jack-O-Lanterns; you'll need to bring me the components.";
        }
        if (unlockedScrying) {
          dialog.text = "Wow! You really like Jack-O-Lanterns!!\nI know it's not much, but why don't you take this weird thing I found? I haven't had a friend in a long time...";
        }
      }
      add(shopButton);
      add(shopButton.infoGroup);
    } else {
      dialog.text = "If I had a pumpkin and a candle, I would make you a wonderful Jack-O-Lantern.";
    }

    FlxG.camera.antialiasing = true;

    add(new NavGroup("Basement"));
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
    Resources.update();
    if (shopButton == null) return;

    if (Math.isNaN(Reg.inventory.Pumpkin) || Math.isNaN(Reg.inventory.Candle)) {
      if(shopButton.enabled) shopButton.disable();
    }
    if (Reg.inventory.Pumpkin >= 1 && Reg.inventory.Candle >= 1) {
      if(!shopButton.enabled) shopButton.enable();
    } else {
      if(shopButton.enabled) shopButton.disable();
    }
  }
}
