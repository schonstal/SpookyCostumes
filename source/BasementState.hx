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

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());

    dialog = new DialogGroup();
    dialog.text = "Bring me your candles and pumpkins and I can make you Jack-O-Lanterns!\n\nKids love 'em.";
    add(dialog);
    
    var shopButton:GradientButton;
    
    var width = 700;
    var height = 150;
    shopButton = new GradientButton(120, 150, width, height, "Carve Pumpkins", new ItemInfoGroup("Jack-O-Lantern"));
    shopButton.onUp.callback = function():Void {
      if (Reg.inventory.Pumpkin >= 1 && Reg.inventory.Candle >= 1) {
        Reg.inventory.Pumpkin--;
        Reg.inventory.Candle--;
        Reg.addItem("Jack-O-Lantern");
        dialog.text = "My pleasure! As always.";
        Reg.inventory.influence++;
      } else {
        dialog.text = "I can't do it without the right parts.";
      }
    }
    add(shopButton);

    FlxG.camera.antialiasing = true;

    add(shopButton.infoGroup);

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
