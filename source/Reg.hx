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
  public var _locations:Dynamic;

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
        thralls: 0,
        fame: 0
      };
    }
    return instance._save.data.inventory;
  }

  static function set_inventory(value:Dynamic):Dynamic {
    instance._save.data.inventory = value;
    return instance._save.data.inventory;
  }

  public static function itemHeld(itemName:String):Float {
    var quantity:Float = Reflect.getProperty(inventory, itemName);
    if (Math.isNaN(quantity)) quantity = 0;
    return quantity;
  }

  public static function addItem(itemName:String, amount:Float=1):Void {
    var quantity:Float = itemHeld(itemName);
    quantity += amount;
    Reflect.setProperty(inventory, itemName, quantity);
  }

  //Unlocks
  public static var unlocks(get, set):Dynamic;

  static function get_unlocks():Dynamic {
    if(instance._save.data.unlocks == null) {
      instance._save.data.unlocks = {
        locations: ["Lair"]
      };
    }
    return instance._save.data.unlocks;
  }

  static function set_unlocks(value:Dynamic):Dynamic {
    instance._save.data.unlocks = value;
    return instance._save.data.unlocks;
  }

  public static function unlockLocation(location:String):Void {
    if (Reg.unlocks.locations.indexOf(location) < 0) {
      Reg.unlocks.locations.push(location);
    }
  }

  //Available items
  public static var items(get, set):Dynamic;

  static function get_items():Dynamic {
    if(instance._save.data.items == null) {
      instance._save.data.items = {
        "Pumpkin": {
          description: "A decorative squash.",
          purchaseText: "Great for carving!",
          cost: {
            blood: 30
          }
        },
        "Candle": {
          description: "A long, waxy stick.\nGood for parties.",
          purchaseText: "Perfectly sized for a pumpkin!",
          cost: {
            blood: 10
          }
        },
        "Basement Key": {
          description: "Unlocks the basement.",
          purchaseText: "I wonder what's down there...",
          max: 1,
          cost: {
            blood: 100
          }
        },
        "Beguiler": {
          description: "Enthralls trick-or-treaters.",
          purchaseText: "Kids will happily give you their blood; they're having fun!",
          max: 10,
          cost: {
            blood: 250
          }
        },
        "Cauldron": {
          description: "Bubble bubble toil and trouble.",
          purchaseText: "I don't know what this is used for; I got it from the witch queen. " +
                        "She said, \"don't let this fall into the wrong hands!\" or something weird like that.",
          max: 1,
          cost: {
            blood: 1000
          }
        },
        "Jack-O-Lantern": {
          description: "Artisanal carved pumpkin.",
          cost: {
            "Pumpkin": 1,
            "Candle": 1
          }
        },
        "Rite of Blood": {
          description: "Magically increases blood harvested.",
          purchaseText: "We will suck the blood of the world!",
          ownedText: "Completed",
          cost: {
            thralls: 10,
            blood: 2500
          }
        },
        "Rite of Majesty": {
          description: "Magically increases your fame's influence.",
          purchaseText: "Our pumpkins seem to have a much better conversion rate!",
          ownedText: "Completed",
          cost: {
            thralls: 10,
            fame: 25
          }
        },
        "Rite of The Hallow": {
          description: "The Danse Macabre. Rule All Hallow's Eve.",
          puchaseText: "You win!",
          ownedText: "Completed",
          cost: {
            thralls: 666,
            fame: 7500,
            blood: 2000000,
            "Ancient Relic": 1
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

  //Available locations
  public static var locations(get, set):Dynamic;

  static function get_locations():Dynamic {
    if(instance._locations == null) {
      instance._locations = {
        "Lair": {
          state: LairState
        },
        "Door": {
          state: DrinkState
        },
        "Shoppe": {
          state: ShopState
        },
        "Basement": {
          state: BasementState
        },
        "Cauldron": {
          state: CauldronState
        }
      };
    }
    return instance._locations;
  }

  static function set_locations(value:Dynamic):Dynamic {
    instance._locations = value;
    return instance._locations;
  }

  public static function location(locationName:String):Dynamic {
    return Reflect.getProperty(locations, locationName);
  }

  public function new() {
    _save = new FlxSave();
    _save.bind("" + Math.random());
  }
}
