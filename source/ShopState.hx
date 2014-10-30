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

  var width = 300;
  var height = 80;

  var buttons:Array<GradientButton> = [];

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());

    dialog = new DialogGroup();
    dialog.text = "I've got a lot of stuff on sale for Halloween. Take a look!";
    add(dialog);
    
    //Make this a dynamic later? Or maybe have a class for an object.
    var availableItems:Array<String> = ["Candle", "Pumpkin", "Beguiler"];//, "JoJo", "Uhg", "Candy Bar", "A Thing"];

    if (!Reg.unlocks.basement) availableItems.push("Basement Key");
    if (!Reg.unlocks.cauldron) availableItems.push("Cauldron");
    
    var i:Int = 0;
    for (itemName in availableItems) {
      var shopButton:GradientButton;
      shopButton = new GradientButton(170 + (i%2 * (width + 10)), 115 + Math.floor(i/2) * (height + 10), width, height, itemName, new ItemInfoGroup(itemName));
      shopButton.onUp.callback = function():Void {
        var item:Dynamic = Reg.item(itemName);
        if (Reg.inventory.blood < item.cost.blood) {
          dialog.text = "You don't have enough blood to buy that.";
        } else if (!Math.isNaN(item.max) && item.max <= Reg.itemHeld(itemName)) {
          dialog.text = "You can't carry any more of those.";
        } else {
          Reg.inventory.blood -= Math.floor(item.cost.blood);
          Reg.addItem(itemName);
          dialog.text = item.purchaseText == null ? "A fine choice." : item.purchaseText;
          if (itemName == "Basement Key") {
            Reg.unlocks.basement = true;
          }
          if (itemName == "Cauldron") {
            Reg.unlocks.cauldron = true;
          }
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
    var i:Int = 0;
    for (button in buttons) {
      var itemName:String = button.label.text;
      var item:Dynamic = Reg.item(itemName);
      if (!Math.isNaN(item.max) && item.max <= Reg.itemHeld(itemName) || Reg.inventory.blood < item.cost.blood) {
        if(button.enabled) button.disable();
      } else {
        if(!button.enabled) button.enable();
      }
      button.x = 170 + (i%2 * (width + 10));
      button.y = 115 + Math.floor(i/2) * (height + 10);
      i++;
    }
    super.update();
    Resources.update();
  }
}
