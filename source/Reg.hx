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

  public static var newLocation:String = "";

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

  public static function reset():Void {
    instance._save.data.inventory = {
      blood: 0,
      kids: 0,
      thralls: 0,
      fame: 0
    };
    instance._save.data.unlocks = {
      locations: ["Door", "Lair"]
    };
  }

  //Unlocks
  public static var unlocks(get, set):Dynamic;

  static function get_unlocks():Dynamic {
    if(instance._save.data.unlocks == null) {
      instance._save.data.unlocks = {
        locations: ["Door", "Lair"]
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
      newLocation = location;
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
        "Pumpkin Box": {
          description: "10 decorative squashes.",
          purchaseText: "Great for carving!",
          cost: {
            blood: 300
          }
        },
        "Candle Box": {
          description: "10 scented candles.",
          purchaseText: "Perfectly sized for a pumpkin!",
          cost: {
            blood: 100
          }
        },
        "Pumpkin Crate": {
          description: "100 decorative squashes.",
          purchaseText: "Great for carving!",
          cost: {
            blood: 3000
          }
        },
        "Candle Crate": {
          description: "100 scented candles.",
          purchaseText: "Perfectly sized for a pumpkin!",
          cost: {
            blood: 1000
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
        "10 Jack-O-Lanterns": {
          description: "Artisanal carved pumpkin.",
          cost: {
            "Pumpkin": 100,
            "Candle": 100
          }
        },
        "100 Jack-O-Lanterns": {
          description: "Artisanal carved pumpkin.",
          cost: {
            "Pumpkin": 100,
            "Candle": 100
          }
        },
        "Moon Dust": {
          description: "It's like catnip for werewolves.",
          purchaseText: "This is some really high quality dust! None of that waxing gibbous garbage--it's pure full-moon!",
          cost: {
          },
          max: 5,
        },
        "Ancient Relic": {
          description: "The fabled artifact",
          purchaseText: "We gotta take this to the cauldron right now!",
          cost: {
          },
          max: 1,
        },
        "Skeleton Key": {
          description: "Get into locked doors.",
          purchaseText: "This key will get you into the graveyard.",
          max: 1,
          cost: {
            "Bone Shard": 10
          }
        },
        "Bone Shard": {
          description: "A small piece of bone.",
          purchaseText: "I don't really know what you'd want this for, but they seem to be popular these days!",
          cost: {
            blood: 100
          }
        },
        "Bone Hammer": {
          description: "Needed to forge bone.",
          purchaseText: "There's a bonesmith down the road; he knows how to use this.",
          max: 1,
          cost: {
            blood: 1000
          }
        },
        "Harvester": {
          description: "Automatically collect blood from a distance.",
          purchaseText: "I've always wanted one of these!",
          max: 1,
          cost: {
            blood: 8000
          }
        },
        "Bone Dagger": {
          description: "Carves pumpkins much faster.",
          purchaseText: "Take this to the carver straight away!",
          max: 1,
          cost: {
            blood: 1500
          }
        },
        "Candleabra": {
          description: "An ornate candle holder.",
          purchaseText: "Wow, this is beautiful!",
          cost: {
            "Candle": 10,
            "Bone Shard": 3
          }
        },
        //Rites
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
            fame: 10,
            blood: 2000
          }
        },
        "Rite of The Hallow": {
          description: "The Danse Macabre. Rule All Hallow's Eve.",
          puchaseText: "...",
          ownedText: "Completed",
          cost: {
            thralls: 25,
            fame: 666,
            blood: 100000,
            "Ancient Relic": 1
          }
        },
        //Scries
        "Haunted Burg": {
          description: "The local neighborhood.",
          purchaseText: "My oh my! Megan's the lucky winner! She's gonna have a great time in the burg!",
          ownedText: "Assigned",
          max: 1,
          cost: {
            thralls: 1,
            blood: 1000
          }
        },
        "Ancient Boneyard": {
          description: "Where the dead go to rest.",
          purchaseText: "This is gonna be good. I can feel it. We'll send Brandon.",
          ownedText: "Assigned",
          max: 1,
          cost: {
            thralls: 1,
            blood: 2500,
            "Skeleton Key": 1
          }
        },
        "Darkwood Forest": {
          description: "It's dark. It's wood. It's a forest.",
          purchaseText: "Oh my! Jimmy Jimmy James! It's James's turn to go out to the forest!",
          ownedText: "Assigned",
          max: 1,
          cost: {
            thralls: 1,
            blood: 5000,
            "Moon Dust": 5
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
          state: LairState,
          longName: "Lair"
        },
        "Door": {
          state: DrinkState,
          longName: "Front Door"
        },
        "Shoppe": {
          state: ShopState,
          longName: "Vampyre Shoppe"
        },
        "Basement": {
          state: BasementState,
          longName: "Basement"
        },
        "Cauldron": {
          state: CauldronState,
          longName: "Witch Queen's Cauldron"
        },
        "Space": {
          state: SpaceState,
          longName: "The Moon"
        },
        "Boneyard": {
          state: BoneyardState,
          longName: "Ancient Boneyard"
        },
        "Forest": {
          state: CircleState,
          longName: "Darkwood Forest"
        },
        "Burg": {
          state: BurgState,
          longName: "Haunted Burg"
        },
        "Pool": {
          state: ScryState,
          longName: "Scrying Pool"
        },
        "Spooky": {
          state: SpookyState,
          longName: "Spooky Shoppe"
        },
        "Circle": {
          state: CircleState,
          longName: "Magic Circle"
        },
        "Harvester": {
          state: HarvestState,
          longName: "Harvester"
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
