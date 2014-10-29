package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class CauldronState extends FlxState
{
  var titleText:FlxText;
  var infoGroup:ItemInfoGroup;
  var dialog:DialogGroup;

  var width = 610;
  var height = 80;

  var buttons:Array<GradientButton> = [];

  override public function create():Void {
    super.create();
    Transition.finish();
    Reg.unlockLocation("Cauldron");

    add(new BackgroundGroup());

    dialog = new DialogGroup();
    dialog.text = "With this we will finally be able control the Spirit of Halloween, bring eternal nightfall upon the world and reign in this eventide kingdom for the rest of time!";
    add(dialog);
    
    //Make this a dynamic later? Or maybe have a class for an object.
    var availableItems:Array<String> = ["Rite of The Hallow", "Rite of Blood", "Rite of Majesty"];

    var i:Int = 0;
    for (itemName in availableItems) {
      var shopButton:GradientButton;
      shopButton = new GradientButton(170, 115 + i * (height + 10), width, height, itemName, new ItemInfoGroup(itemName));
      shopButton.onUp.callback = function():Void {
        var item:Dynamic = Reg.item(itemName);
        for (cost in Reflect.fields(item.cost)) {
          var price:Float = Reflect.getProperty(item.cost, cost);
          if (Reg.itemHeld(cost) < price) {
            dialog.text = "You need more " + cost + " to perform this ritual.";
            return;
          }
        }
        for (cost in Reflect.fields(item.cost)) {
          var price:Float = Reflect.getProperty(item.cost, cost);
          Reg.addItem(cost, -price);
        }
        dialog.text = item.purchaseText == null ? "A fine choice." : item.purchaseText;
        Reg.addItem(itemName);
      }
      add(shopButton);
      buttons.push(shopButton);
      i++;
    }

    FlxG.camera.antialiasing = true;

    for (button in buttons) {
      add(button.infoGroup);
    }
    
    add(new NavGroup("Witch Queen's Cauldron"));
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    var i:Int = 0;
    for (button in buttons) {
      var itemName:String = button.label.text;
      var item:Dynamic = Reg.item(itemName);
      var canAfford:Bool = true;
      for (cost in Reflect.fields(item.cost)) {
        if(Reflect.getProperty(item.cost, cost) > Reg.itemHeld(item)) canAfford = false;
      }

      if (!Math.isNaN(item.max) && item.max <= Reg.itemHeld(itemName) || !canAfford) {
        if(button.enabled) button.disable();
      } else {
        if(!button.enabled) button.enable();
      }
      button.x = 170;
      button.y = 115 + i * (height + 10);
      i++;
    }
    super.update();
    Resources.update();
  }
}
