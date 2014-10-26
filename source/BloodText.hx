package;

import flixel.text.FlxText;

class BloodText extends FlxText
{
  public function new() {
    super(20,10);
    setFormat("assets/fonts/AmaticSC-Regular.ttf", 64, 0xffffffff, "left");
  }

  override public function update():Void {
    text = "";
    if (Reg.inventory.blood > 0) {
      text += "Blood: " + Math.floor(Reg.inventory.blood) + "\n";
    }
    super.update();
  }
}
