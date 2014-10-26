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
        blood: 0,
        kids: 0,
        influence: 0,
        items: {}
      };
    }
    return instance._save.data.inventory;
  }

  static function set_inventory(value:Dynamic):Dynamic {
    instance._save.data.inventory = value;
    return instance._save.data.inventory;
  }

  //Unlocks
  public static var unlocks(get, set):Dynamic;

  static function get_unlocks():Dynamic {
    if(instance._save.data.unlocks == null) {
      instance._save.data.unlocks = {
        trick: false,
        lair: false
      };
    }
    return instance._save.data.unlocks;
  }

  static function set_unlocks(value:Dynamic):Dynamic {
    instance._save.data.unlocks = value;
    return instance._save.data.unlocks;
  }

  //Available items
  public static var items(get, set):Dynamic;

  static function get_items():Dynamic {
    if(instance._save.data.items == null) {
      instance._save.data.items = {
        "Pumpkin": {
          description: "A decorative squash.",
          cost: {
            blood: 10
          }
        },
        "Candle": {
          description: "A long, waxy stick.\nGood for parties.",
          cost: {
            blood: 10
          }
        },
        "Basement Key": {
          description: "Unlocks the basement.",
          cost: {
            blood: 50
          }
        },
        "Beguiler": {
          description: "Spellbinds trick-or-treaters.",
          cost: {
            blood: 100
          }
        },
        "Cauldron": {
          description: "Bubble bubble toil and trouble.",
          cost: {
            blood: 1000
          }
        }
      };
    }
    return instance._save.data.items;
  }

  static function set_items(value:Dynamic):Dynamic {
    instance._save.data.items = value;
    return instance._save.data.items;
  }

  public static function item(itemName:String):Dynamic {
    return Reflect.getProperty(items, itemName);
  }

  public function new() {
    _save = new FlxSave();
    _save.bind("" + Math.random());
  }
}
