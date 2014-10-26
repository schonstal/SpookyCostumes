package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxGradient;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;

class ItemInfoGroup extends FlxSpriteGroup
{
  var infoBox:InfoBox;
  var item:Dynamic;
  var itemName:String;
  
  var nameText:FlxText;
  var descriptionText:FlxText;
  var costText:FlxText;

  public function new(ItemName:String) {
    super();

    infoBox = new InfoBox(400,300);
    add(infoBox);
    itemName = ItemName;
    item = Reg.item(ItemName);

    //FlxTween.tween(infoBox.offset, { y: 10 }, 1, { type: FlxTween.PINGPONG, ease: FlxEase.sineInOut });
    //exists = false;
    visible = false;
//    alpha = 0;

    nameText = new FlxText(0,0,400,100);
    nameText.setFormat("assets/fonts/AmaticSC-Regular.ttf", 54, 0xfff2ac6d, "left");
    nameText.text = ItemName;
    add(nameText);

    descriptionText = new FlxText(0,0,400,200);
    descriptionText.setFormat("assets/fonts/RobotoSlab-Thin.ttf", 32, 0xffd2cae1, "left");
    descriptionText.text = item.description;
    add(descriptionText);
  }

  public override function update():Void {
    super.update();
    infoBox.x = FlxG.mouse.x;
    infoBox.y = FlxG.mouse.y;

    nameText.x = infoBox.x + 18;
    nameText.y = infoBox.y + 8;
    nameText.alpha = infoBox.alpha;

    descriptionText.x = infoBox.x + 18;
    descriptionText.y = infoBox.y + 65;
    descriptionText.alpha = infoBox.alpha;
  }

  public function show():Void {
    FlxTween.tween(infoBox, { alpha: 0.9 }, 0.2, { ease: FlxEase.quartOut });
    visible = true;
  }

  public function hide():Void {
    FlxTween.tween(infoBox, { alpha: 0 }, 0.2, { ease: FlxEase.quartOut, onComplete: function(t):Void {
      visible = false;
    }});
  }
}
