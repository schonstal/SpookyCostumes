package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxGradient;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;

class ItemInfoGroup extends InfoGroup
{
  var item:Dynamic;
  var itemName:String;
  
  var nameText:FlxText;
  var descriptionText:FlxText;
  var costTexts:Array<FlxText> = [];
  var ownedText:FlxText;
  var costLength:Int;

  public function new(ItemName:String) {
    item = Reg.item(ItemName);
    costLength = Reflect.fields(item.cost).length;
    super(400,250 + 60 * costLength);

    itemName = ItemName;

    //FlxTween.tween(infoBox.offset, { y: 10 }, 1, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut });
    //exists = false;
    visible = false;
//    alpha = 0;

    nameText = new FlxText(0,0,400,100);
    nameText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 54, 0xfff2ac6d, "left");
    nameText.text = ItemName;
    add(nameText);

    descriptionText = new FlxText(0,0,360,200);
    descriptionText.setFormat("assets/fonts/RobotoSlab-Thin.ttf", 32, 0xffd2cae1, "left");
    descriptionText.text = item.description;
    add(descriptionText);

    for (i in 0...costLength) {
      var costText:FlxText;
      costText = new FlxText(0,0,400,100);
      costText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 54, 0xfff08382, "left");
      costTexts.push(costText);
      add(costText);
    }

    ownedText = new FlxText(0,0,400,100);
    ownedText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 54, 0xffbf69e7, "left");
    add(ownedText);
  }

  public override function update():Void {
    super.update();
    infoBox.x = FlxG.mouse.x;
    infoBox.y = FlxG.mouse.y;

    nameText.x = infoBox.x + 22;
    nameText.y = infoBox.y + 8;
    nameText.alpha = infoBox.alpha;

    descriptionText.x = infoBox.x + 22;
    descriptionText.y = infoBox.y + 75;
    descriptionText.alpha = infoBox.alpha;

    var i:Int = 0;
    for (text in costTexts) {
      text.x = infoBox.x + 22;
      text.y = infoBox.y + 160 + 60 * i;
      text.alpha = infoBox.alpha;
      text.text = Reflect.fields(item.cost)[i] + ": "
                  + Reflect.getProperty(item.cost,Reflect.fields(item.cost)[i]);

      text.text += " (" + Math.floor(Reg.itemHeld(Reflect.fields(item.cost)[i])) + ")";
      i++;
    }

    ownedText.x = infoBox.x + 22;
    ownedText.y = infoBox.y + 160 + 60 * costLength;
    ownedText.alpha = infoBox.alpha;

    ownedText.text = (item.ownedText ? item.ownedText : "Owned") + ":" + Reg.itemHeld(itemName);
    if (!Math.isNaN(item.max)) {
      ownedText.text += "/" + item.max;
    }
  }
}
