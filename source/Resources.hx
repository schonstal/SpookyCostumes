import flixel.FlxG;
import haxe.Timer;

class Resources {
  static var lastTime:Float = 0;

  public static function update() {
    var timeDifference = (lastTime > 0 ? Timer.stamp() - lastTime : 0);

    Reg.inventory.kids += timeDifference * Math.log(Reg.inventory.influence + Math.exp(1));
    Reg.inventory.thralls += timeDifference * Reg.itemHeld("Beguiler")/60;

    lastTime = Timer.stamp();
    
    if (FlxG.keys.justPressed.Q) Reg.inventory.blood += 1000;
  }

  public static function harvestBlood() {
    if (Reg.inventory.blood == null) Reg.inventory.blood = 0;
    Reg.inventory.blood += Reg.inventory.kids;
    Reg.inventory.kids = 0;
  }

  public static function harvestInfluence() {
    if (Reg.inventory.influence == null) Reg.inventory.influence = 0;
    Reg.inventory.influence += Reg.inventory.kids / 100;
    Reg.inventory.kids = 0;
  }
}
