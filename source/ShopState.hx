package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class ShopState extends FlxState
{
  var titleText:FlxText;
  var infoGroup:ItemInfoGroup;
  var dialog:DialogGroup;

  var buttons:Array<GradientButton> = [];

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());

    dialog = new DialogGroup();
    dialog.text = "I've got a lot of stuff on sale for Halloween. Take a look!";
    add(dialog);
    
    var shopButton:GradientButton;
    //Make this a dynamic later? Or maybe have a class for an object.
    var availableItems:Array<String> = ["Candle", "Pumpkin", "Cauldron", "Basement Key", "Beguiler"];//, "JoJo", "Uhg", "Candy Bar", "A Thing"];
    
    var i:Int = 0;
    for (item in availableItems) {
      var width = 350;
      var height = 100;
      shopButton = new GradientButton(120 + (i%2 * (width + 10)), 90 + Math.floor(i/2) * (height + 10), width, height, item, new ItemInfoGroup(item));
      shopButton.onUp.callback = function():Void {
        if (Reg.inventory.blood > Reg.item(item).cost.blood) {
          Reg.inventory.blood -= Math.floor(Reg.item(item).cost.blood);
          Reg.addItem(item);
          dialog.text = "A fine choice.";
          if (item == "Basement Key") {
            Reg.unlocks.basement = true;
          }
        } else {
          dialog.text = "You don't have enough blood to buy that.";
        }
      }
      add(shopButton);
      buttons.push(shopButton);
      i++;
    }

    FlxG.camera.antialiasing = true;


    for (button in buttons) {
      add(button.infoGroup);
    }
    
    add(new NavGroup("Vampyre Shoppe"));
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    for (button in buttons) {
      var item:String = button.label.text;
      if (Reg.inventory.blood > Reg.item(item).cost.blood) {
        if(!button.enabled) button.enable();
      } else {
        if(button.enabled) button.disable();
      }
    }
    super.update();
    Resources.update();
  }
}
