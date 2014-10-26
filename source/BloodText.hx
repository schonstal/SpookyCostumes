package;

import flixel.text.FlxText;

class BloodText extends FlxText
{
  public function new() {
    super(20,10);
    setFormat("assets/fonts/AmaticSC-Regular.ttf", 64, 0xffeadbf4, "left");
  }

  override public function update():Void {
    text = "";
    if (Math.floor(Reg.inventory.blood) > 0) {
      text += "Blood: " + Math.floor(Reg.inventory.blood) + "\n";
    }
    if (Math.floor(Reg.inventory.influence) > 0) {
      text += "Fame: " + Math.floor(Reg.inventory.influence) + "\n";
    }
    super.update();
  }
}
