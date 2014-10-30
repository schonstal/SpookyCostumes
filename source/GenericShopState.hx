package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class GenericShopState extends FlxState
{
  var titleText:FlxText;
  var infoGroup:ItemInfoGroup;
  var dialog:DialogGroup;
  var availableItems:Array<String> = ["Candle", "Pumpkin", "Beguiler"];
  var columns:Float = 1;

  var maxText:String = "You can't hold any more of that.";
  var affordText:String = "You can't afford that.";
  var purchaseText:String = "A fine choice.";
  var flavorText:String = "Welcome to my shop!";
  var title:String = "A shop.";

  var width = 610;
  var height = 80;

  var buttons:Array<GradientButton> = [];

  override public function create():Void {
    super.create();
    Transition.finish();

    add(new BackgroundGroup());

    dialog = new DialogGroup();
    dialog.text = flavorText;
    add(dialog);

    width = (610 - ((columns - 1) * 10))/columns;
    
    var i:Int = 0;
    for (itemName in availableItems) {
      var shopButton:GradientButton;
      shopButton = new GradientButton(170 + (i%columns * (width + 10)), 115 + Math.floor(i/columns) * (height + 10), width, height, itemName, new ItemInfoGroup(itemName));
      shopButton.onUp.callback = function():Void {
        var item:Dynamic = Reg.item(itemName);
        if (!Math.isNaN(item.max) && item.max <= Reg.itemHeld(itemName)) {
          dialog.text = maxText;
          return;
        }
        for (cost in Reflect.fields(item.cost)) {
          var price:Float = Reflect.getProperty(item.cost, cost);
          if (Reg.itemHeld(cost) < price) {
            dialog.text = affordText;
            return;
          }
        }
        for (cost in Reflect.fields(item.cost)) {
          var price:Float = Reflect.getProperty(item.cost, cost);
          Reg.addItem(cost, -price);
        }
        dialog.text = item.purchaseText == null ? purchaseText : item.purchaseText;
        Reg.addItem(itemName);
        purchaseCallback(itemName);
      }
      add(shopButton);
      buttons.push(shopButton);
      i++;
    }

    FlxG.camera.antialiasing = true;

    for (button in buttons) {
      add(button.infoGroup);
    }
    
    add(new NavGroup(title));
  }

  private function purchaseCallback(itemName:String):Void {
    return;
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
      button.x = 170 + (i%columns * (width + 10));
      button.y = 115 + Math.floor(i/columns) * (height + 10);
      i++;
    }
    super.update();
    Resources.update();
  }
}
