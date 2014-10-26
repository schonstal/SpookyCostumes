package;

import org.flixel.*;
import org.flixel.plugin.photonstorm.*;
import flash.geom.Rectangle;
import com.greensock.*;
import com.greensock.easing.*;

public class TransitionGroup extends FlxGroup
{
  private var transitionSprites:Array = new Array();
  public var reverse:Boolean = false;
  public var onCompleteCallback:Function;

  public function new(reverse:Boolean=false) {
    this.reverse = reverse;
    for(var i:int = 0; i * 24 < FlxG.width; i++) {
      transitionSprites[i] = new Array();
      for(var j:int = 0; j * 24 < FlxG.height; j++) {
        makeTransitionSprite(i,j);
      }
    }

    var overlayGradient:FlxSprite = new FlxSprite();
    overlayGradient.loadGraphic(Assets.Gradient);
    overlayGradient.blend = "overlay";
    overlayGradient.alpha = 0.4;
    overlayGradient.scrollFactor.x = overlayGradient.scrollFactor.y = 0;
    add(overlayGradient);
  }

  public function go(onComplete:Function=null):void {
    onCompleteCallback = onComplete;

    for(var i:int = 0; i * 24 < FlxG.width; i++) {
      for(var j:int = 0; j * 24 < FlxG.height; j++) {
        tweenSprite(i,j);
      }
    }
  }

  private function tweenSprite(i:Number, j:Number):void {
    new FlxTimer().start(0.01 + 0.01*(i+j), 1, function():void {
      TweenMax.to(transitionSprites[i][j].scale, 0.1, {
        x: reverse ? 1 : 0,
        y: reverse ? 1 : 0,
        ease:Quad.easeIn,
        onComplete: function():void {
          if(i == 31 && j == 17) {
            if(onCompleteCallback != null) onCompleteCallback();
            reverse = !reverse;
          }
        }
      });
    });
  }

  private function makeTransitionSprite(i:Number, j:Number):void {
    var transitionSprite:FlxSprite = new FlxSprite();
    transitionSprite.makeGraphic(24, 24, (i + j) % 2 == 0 ? 0xff9990ef : 0xffaba6ff);
    transitionSprite.x = transitionSprite.width * i;
    transitionSprite.y = transitionSprite.height * j;
    transitionSprite.scrollFactor.x = transitionSprite.scrollFactor.y = 0;
    if(reverse) {
      transitionSprite.scale.x = transitionSprite.scale.y = 0;
    }
    transitionSprites[i][j] = transitionSprite;
    add(transitionSprite);
  }
}
