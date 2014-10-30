package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class ScryState extends FlxState
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

    add(new BackgroundGroup());

    dialog = new DialogGroup();
    dialog.text = "From here you can dispatch your thralls, after which you'll be able to act through them as a surrogate.";
    add(dialog);
    
    //Make this a dynamic later? Or maybe have a class for an object.
    var availableItems:Array<String> = ["Ancient Boneyard", "Darkwood Forest", "Haunted Burg"];

    var i:Int = 0;
    for (itemName in availableItems) {
      var shopButton:GradientButton;
      shopButton = new GradientButton(170, 115 + i * (height + 10), width, height, itemName, new ItemInfoGroup(itemName));
      shopButton.onUp.callback = function():Void {
        var item:Dynamic = Reg.item(itemName);
        if (!Math.isNaN(item.max) && item.max <= Reg.itemHeld(itemName)) {
          dialog.text = "You've already assigned a thrall to this location.";
          return;
        }
        for (cost in Reflect.fields(item.cost)) {
          var price:Float = Reflect.getProperty(item.cost, cost);
          if (Reg.itemHeld(cost) < price) {
            dialog.text = "You don't have quite what it takes to go there yet.";
            return;
          }
        }
        for (cost in Reflect.fields(item.cost)) {
          var price:Float = Reflect.getProperty(item.cost, cost);
          Reg.addItem(cost, -price);
        }
        dialog.text = item.purchaseText == null ? "An excellent destination." : item.purchaseText;
        Reg.addItem(itemName);
        Reg.unlockLocation(itemName.split(" ")[1]);
      }
      add(shopButton);
      buttons.push(shopButton);
      i++;
    }

    FlxG.camera.antialiasing = true;

    for (button in buttons) {
      add(button.infoGroup);
    }
    
    add(new NavGroup("Scrying Pool"));
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
        var price:Float = Reflect.getProperty(item.cost, cost);
        if (Reg.itemHeld(cost) < price) {
          canAfford = false;
        }
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
