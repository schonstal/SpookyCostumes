import flixel.FlxG;
import haxe.Timer;

class Resources {
  static var lastTime:Float = 0;

  public static function update() {
    var timeDifference = (lastTime > 0 ? Timer.stamp() - lastTime : 0);

    Reg.inventory.kids += timeDifference * (Math.log(Reg.inventory.fame + Math.exp(1)) + Reg.itemHeld("Rite of Majesty"));
    Reg.inventory.thralls += timeDifference * Reg.itemHeld("Beguiler")/100;

    lastTime = Timer.stamp();
    
    if (FlxG.keys.justPressed.Q) Reg.inventory.blood += 999999;
    if (FlxG.keys.justPressed.W) Reg.inventory.fame += 10;
    if (FlxG.keys.justPressed.E) Reg.inventory.thralls += 10;
    if (FlxG.keys.justPressed.A) Transition.to(new WinState());

    if (FlxG.keys.justPressed.SPACE) Transition.to(new SpaceState());

    if (Reg.itemHeld("Harvester") >= 1) harvestBlood();
  }

  public static function harvestBlood() {
    if (Reg.inventory.blood == null) Reg.inventory.blood = 0;
    Reg.inventory.blood += Reg.inventory.kids * (Reg.itemHeld("Rite of Blood")/10 + 1);
    Reg.inventory.kids = 0;
  }

  public static function harvestInfluence() {
    if (Reg.inventory.fame == null) Reg.inventory.fame = 0;
    Reg.inventory.fame += Reg.inventory.kids / 100;
    Reg.inventory.kids = 0;
  }
}
