package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
  public var _save:FlxSave;

  static var _instance;

  static var instance(get, set):Reg;

  static function get_instance():Reg {
    if (_instance == null) {
      _instance = new Reg();
    }

    return _instance;
  }

  static function set_instance(value:Reg):Reg {
    return instance;
  }

  //Save
  public static var save(get, set):FlxSave;

  static function get_save():FlxSave {
    return instance._save;
  }

  static function set_save(value:FlxSave):FlxSave {
    return instance._save;
  }

  //Blood
  public static var blood(get, set):Float;

  static function get_blood():Float {
    if(instance._save.data.blood == null || Math.isNaN(instance._save.data.blood))
      instance._save.data.blood = 0;
    return instance._save.data.blood;
  }

  static function set_blood(value:Float):Float {
    instance._save.data.blood = value;
    return instance._save.data.blood;
  }

  public function new() {
    _save = new FlxSave();
    _save.bind("Witches");
  }
}
