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

  //Inventory
  public static var inventory(get, set):Dynamic;

  static function get_inventory():Dynamic {
    if(instance._save.data.inventory == null) {
      instance._save.data.inventory = {
        blood: 0
      };
    }
    return instance._save.data.inventory;
  }

  static function set_inventory(value:Dynamic):Dynamic {
    instance._save.data.inventory = value;
    return instance._save.data.inventory;
  }

  public function new() {
    _save = new FlxSave();
    _save.bind("Witches");
  }
}
