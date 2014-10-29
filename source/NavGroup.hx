package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxGradient;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flash.display.BlendMode;

class NavGroup extends FlxSpriteGroup
{
  var blackBarSprite:FlxSprite;
  var bloodText:FlxText;
  var titleText:FlxText;
  var burger:FlxSprite;
  var gradient:FlxSprite;
  var inMenu:Bool = false;
  var transitioning:Bool = false;

  var locationButtons:Array<FlxText> = [];

  public function new(name:String, enabled:Bool=true) {
    super();
    gradient = FlxGradient.createGradientFlxSprite(Std.int(FlxG.width/4), FlxG.height, [0xffffffff, 0xff000000], 1, 180);
    gradient.alpha = 0;
    gradient.blend = BlendMode.MULTIPLY;
    add(gradient);

    var locationButton:FlxText;
    var i:Int = 0;
    var locations:Array<Dynamic> = Reg.unlocks.locations;
    for(location in locations) {
      i++;
      locationButton = new FlxText(0, 60 * i, 150, location);
      locationButton.setFormat("assets/fonts/AmaticSC-Bold.ttf", 42, 0xff9f79b7, "left");
      locationButton.alpha = 0;
      add(locationButton);
      locationButtons.push(locationButton);
    }

    blackBarSprite = new FlxSprite();
    blackBarSprite.makeGraphic(FlxG.width, 60, 0xff000000);
    blackBarSprite.alpha = 0.55;
    blackBarSprite.blend = BlendMode.MULTIPLY;
    add(blackBarSprite);

    bloodText = new FlxText(70);
    bloodText.setFormat("assets/fonts/AmaticSC-Bold.ttf", 42, 0xff9f79b7, "left");
    add(bloodText);

    titleText = new FlxText(0,0,FlxG.width-20);
    titleText.setFormat("assets/fonts/AmaticSC-Bold.ttf", 42, 0xff9f79b7, "right");
    titleText.text = name;
    add(titleText);

    burger = new FlxSprite(15, 15);
    burger.loadGraphic("assets/images/burger.png");
    burger.width += 30;
    burger.height += 30;
    burger.color = 0xff9f79b7;
    add(burger);

    if(!enabled) {
      y = -60;
      blackBarSprite.alpha = 0;
      burger.alpha = bloodText.alpha = titleText.alpha = 0;
    }

  }

  override public function update():Void {
    bloodText.text = "Blood: " + Math.floor(Reg.inventory.blood);

    if (Math.floor(Reg.inventory.fame) > 0) {
      bloodText.text += "    Fame: " + Math.floor(Reg.inventory.fame);
    }
    if (Reg.inventory.thralls > 0) {
      bloodText.text += "    Thralls: " + Math.floor(Reg.inventory.thralls);// + " (" + Reg.inventory.Beguiler + "/min)";
    }
    super.update();

    burger.alpha = bloodText.alpha = titleText.alpha;
    if(burger.overlapsPoint(FlxG.mouse.getWorldPosition()) && !inMenu) {
      burger.color = 0xffeadbf4;
      FlxTween.tween(gradient, { alpha: 0.55 }, 0.3, { ease: FlxEase.quartOut });
      for (locationButton in locationButtons) {
        FlxTween.tween(locationButton, { alpha: 1, x: 10 }, 0.1, { ease: FlxEase.quartOut });
      }
      inMenu = true;
    }

    if(inMenu && FlxG.mouse.x > 160) {
      burger.color = 0xff9f79b7;
      FlxTween.tween(gradient, { alpha: 0 }, 0.3, { ease: FlxEase.quartOut });
      for (locationButton in locationButtons) {
        FlxTween.tween(locationButton, { alpha: 0, x: -100 }, 0.1, { ease: FlxEase.quartOut });
      }
      inMenu = false;
    }
    
    if(inMenu && !transitioning) {
      for (locationButton in locationButtons) {
        if (locationButton.overlapsPoint(FlxG.mouse.getWorldPosition())) {
          locationButton.color = 0xffe9a56d; 
          if (FlxG.mouse.justPressed) {
            transitioning = true;
            Transition.to(Type.createInstance(Reg.location(locationButton.text).state, []));
          }
        } else {
          locationButton.color = 0xff9f79b7;
        }
      }
    }
  }

  public function enable():Void {
    FlxTween.tween(this, { y: 0 }, 0.3, { ease: FlxEase.quartOut });
    FlxTween.tween(blackBarSprite, { alpha: 0.55 }, 0.3, { ease: FlxEase.quartOut });
    FlxTween.tween(titleText, { alpha: 1 }, 0.3, { ease: FlxEase.quartOut });
  }
}
