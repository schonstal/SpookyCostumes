import flixel.FlxG;

class Resources {
  public static function update() {
    Reg.inventory.kids += FlxG.elapsed;
  }

  public static function harvestBlood() {
    if (Reg.inventory.blood == null) Reg.inventory.blood = 0;
    Reg.inventory.blood += Reg.inventory.kids;
    Reg.inventory.kids = 0;
  }

  public static function harvestInfluence() {
    if (Reg.inventory.influence == null) Reg.inventory.influence = 0;
    Reg.inventory.influence += Reg.inventory.kids;
    Reg.inventory.kids = 0;
  }
}
