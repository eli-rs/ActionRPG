/* 
 *		Items are contained in a ds_list, individual items are ds_maps containing: 
 *	"name"			: item name
 *	"type"			: item type, used to determine appropriate sprite (i.e. spr_items_accessories, etc)
 *	"value"			: value of item
 *	"description"	: description of item
 *	"id"			: item's index within ds_list global.items, (i.e. item = global.items[| id];)
 *	"image_index"	: item's sprite frame, (i.e. appropriate_sprite = spr_this_type.image_index;)



enum item_rarity_costs {
	common = 10,
	uncommon = 50,
	rare = 250,
	unique = 1000,
	set = 800
}
*/

var names = ["Kelladin's", "Reshi's", "Buuldokk's", "Selena's", "Melf's", "Boltar's", "Eli's", "Max's", 
	"Thanadin's", "Lola's", "Chip's", "Oogb'aa's", "Ren's", "Kel's", "Someone's", "Your Typical", 
	"Johnifer's", "Jennathon's"];

var adjectives = ["Thorned", "Draining", "Vulnerable", "Spiked", "Lawless", "Scorned", "Flighty", 
	"Powerful", "Exaggerated", "Curved", "Keen", "Vicious", "Tepid", "Mellow", "Lacrimose", "Underwhelming",
	"Flaccid", "Dumpy", "Jagged", "Floppy", "Loathsome", "Gregarious", "Satisfactory", "Cheap", "Flatulent",
	"Frugal", "Inexpensive", "Extravagent", "Ropey", "Unadorned", "Litigious", "Greasy", "Demure", 
	"Impotent", "Good Ol' Fashioned", "Papery", "Padded", "Loose", "Flowing"];
	
var prefixes = ["Iron", "Sandalwood", "Steel", "Ethereal", "Leather", "Cloth", "Bronze", "Cedar",
	"Ebon Oak", "Ebony", "Glass", "Pumpernickle", "Stone", "Obsidian"];
	
var weapons = ["Longsword", "Shortsword", "Dagger", "Blade", "Knife", "Butter Knife", "Table Leg",
	"Whip", "Bull-Whip", "Flail", "Halberd", "Mace", "Spear", "Javelin", "Pike", "Trident", "Felling Axe",
	"Hand Axe", "Battle Axe", "Hatchet", "Pocket Knife", "Hammer", "Warhammer", "Wand", "Scepter", 
	"Violin", "Staff", "Glaive", "Claw", "Quill", "Bow", "Longbow", "Shortbow", "Hunting Bow", 
	"Crossbow", "Cutlass", "Scythe"];

var armors = ["Robe", "Coat", "Sack", "Chest Armor", "Cloak", "Plate", "Chainmail", "Shield", 
	"Buckler", "Garment", "Shirt", "Undershirt", "Boots", "Greaves", "Gauntlets", "Gloves", "Shoes",
	"Sandals", "Knickers", "Bracers", "Hat", "Hood", "Helm", "Slipper"];
	
var accessories = ["Bracelet", "Amulet", "Necklace", "Tourniquette", "Cufflinks", "Pendant", "Ring", 
	"Charm", "Pocket Square", "Earring", "Class Ring", "Rabbit's Foot", "Medallion"];

var suffixes = ["of Thumping", "of Whomping", "of Demeaning", "of Killing", "of Crucifying", 
	"of Contemplation", "of Procrastination", "of Fraternizing", "of Earnest Congratulation",
	"of Quiet Defeat", "of Resignation", "of Soulful Pontification", "of Gratiutous Violence",
	"of Self Deprecation", "of Smacking Things", "of Polite Condemnation", "of General Unease",
	"of Senseless Apathy", "of Incomprehensible Clarity", "of Inscrutable Joy", 
	"of Undeserved Admiration"];
	
enum item_types {
	weapons,
	armors,
	accessories
};

var avg_item_value = 0;

var num_items = 30;
var max_item_level = 30;

for (var ilvl = 1; ilvl <= max_item_level; ilvl ++)
{
	var level_items = ds_list_create();
	
	for (var i = 0; i < num_items; i++){
	
		randomize();
		
		var item = ds_map_create();
	
		//determine item type to make
		// GENERATE A RANDOM ITEM TYPE AND ADD IT TO ITEM MAP
		var rand_item_type = irandom_range(0, 15);
		// here "item_type" is just used to determine which list of names to pull from when constructing the item name
		if		(rand_item_type == 0)	ds_map_add(item, "item_type", "Helm"); 
		else if (rand_item_type == 1)	ds_map_add(item, "item_type", "Amulet"); 
		else if (rand_item_type == 2)	ds_map_add(item, "item_type", "Cloak"); 
		else if (rand_item_type == 3)	ds_map_add(item, "item_type", "Chest Armor"); 
		else if (rand_item_type == 4)	ds_map_add(item, "item_type", "Ranged Weapon"); 
		else if (rand_item_type == 5)	ds_map_add(item, "item_type", "Bracers"); 
		else if (rand_item_type == 6)	ds_map_add(item, "item_type", "Belt"); 
		else if (rand_item_type == 7)	ds_map_add(item, "item_type", "Gloves"); 
		else if (rand_item_type == 8)	ds_map_add(item, "item_type", "Ring"); 
		else if (rand_item_type == 9)	ds_map_add(item, "item_type", "Greaves"); 
		else if (rand_item_type == 10)	ds_map_add(item, "item_type", "Boots"); 
		else if (rand_item_type == 11)	ds_map_add(item, "item_type", "Shield");
		else if (rand_item_type == 12)	ds_map_add(item, "item_type", "Tome");
		else if (rand_item_type == 13)	ds_map_add(item, "item_type", "Ammo");
		else if (rand_item_type == 14)	ds_map_add(item, "item_type", "One-Handed Weapon");
		else if (rand_item_type == 15)	ds_map_add(item, "item_type", "Two-Handed Weapon");
		
		var item_type;
		if (item[? "item_type"] == "One-Handed Weapon" || item[? "item_type"] == "Two-Handed Weapon" ||
			item[? "item_type"] == "Ranged Weapon") 
		{	
			item_type = weapons; 
			ds_map_add(item, "base_type", "weapon"); 
		}
		else if (item[? "item_type"] == "Amulet" || item[? "item_type"] == "Ring" || item[? "item_type"] == "Cloak") 
		{ 
			item_type = accessories; 
			ds_map_add(item, "base_type", "accessory"); 
		}
		else if (item[? "item_type"] == "Shield" || item[? "item_type"] == "Tome" || item[? "item_type"] == "Ammo")
		{
			item_type = weapons;
			ds_map_add(item, "base_type", "offhand");
		}
		else
		{ 
			item_type = armors; 
			ds_map_add(item, "base_type", "armor"); 
		}
	
		
		// create item name using random combination of prefixes and suffixes
		var gets_name = false;
		var item_name = "";
		var name = "";
		var adjective = "";
		var prefix = prefixes[irandom_range(0, array_length_1d(prefixes) - 1)];
		
		var type = item[? "item_type"];
			
		var suffix = "";
		item_name = prefix + " " + type;
		
		var prefix_chance = 0.25;
		var adj_chance = 0.4;
		var suffix_chance = 0.3;
		var name_chance = 0.25;
		
		if (random(1.0) < prefix_chance) 
		{
			item_name = prefixes[irandom_range(0, array_length_1d(prefixes) - 1)] + " " + type;
		}
		if (random(1.0) < adj_chance) 
		{
			adjective = adjectives[irandom_range(0, array_length_1d(adjectives) - 1)];
			item_name = adjective + " " + item_name;
			gets_name = true;
		}
		if (random(1.0) < suffix_chance)
		{
			suffix = suffixes[irandom_range(0, array_length_1d(suffixes) - 1)];
			item_name = item_name + " " + suffix;
			gets_name = true;
		}
		if (gets_name && random(1.0) < name_chance)  
		{
			name = names[irandom_range(0, array_length_1d(names) - 1)];
			item_name = name + " " + item_name;
		}
		// determine random price for item
		var name_len = string_length(item_name);
		var item_val = irandom(20) + (irandom_range(1, 4) * name_len);		/// roughly [20 to 80]
		var num_modifiers = ceil(item_val / 20);
		var item_sprite;
		
		// get random sprite for item according to the item type
		var item_base = ds_list_create();
		var index;
		if (item[? "item_type"] == "One-Handed Weapon")
		{
			item_sprite = choose(spr_items_medium_weapons, spr_items_short_weapons, spr_items_wands);
			
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			// average damage based on item level: 4 + 2*lvl, thus: 1:6, 2:8, 3:10, etc
			var lowrange = irandom(5 + (3 * ilvl)); //minimum damage
			var highrange = irandom(6 + (4 * ilvl)); //maximum damage
			item_base[| 0] = min(lowrange, highrange);
			item_base[| 1] = max(lowrange, highrange);
			//if (item_sprite == spr_items_long_weapons) item_base[| 2] = 
		}
		else if (item[? "item_type"] == "Two-Handed Weapon")
		{
			item_sprite = spr_items_long_weapons;
			
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			// average damage based on item level: 4 + 2*lvl, thus: 1:6, 2:8, 3:10, etc
			var lowrange = irandom(12 + (4 * ilvl)); //minimum damage
			var highrange = irandom(14 + (6 * ilvl)); //maximum damage
			item_base[| 0] = min(lowrange, highrange);
			item_base[| 1] = max(lowrange, highrange);
			//if (item_sprite == spr_items_long_weapons) item_base[| 2] = 
		}
		else if (item[? "item_type"] == "Ranged Weapon")
		{
			item_sprite = spr_items_ranged_weapons;
			
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			// average damage based on item level: 4 + 2*lvl, thus: 1:6, 2:8, 3:10, etc
			var lowrange = irandom(8 + (3 * ilvl)); //minimum damage
			var highrange = irandom(8 + (5 * ilvl)); //maximum damage
			item_base[| 0] = min(lowrange, highrange);
			item_base[| 1] = max(lowrange, highrange);
			//if (item_sprite == spr_items_long_weapons) item_base[| 2] = 
		}
		else if (item[? "item_type"] == "Shield")
		{
			item_sprite = spr_items_shields;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			// SHIELD WILL NEED TO HAVE 'SHIELD BLOCK CHANCE/SHIELD RECOVERY TIME' AS ITS BASE VALUES INSTEAD OF ARMOR
			item_base[| 0] = irandom_range(15 + (ilvl / 6), 15 + (ilvl / 3));	// innate shield block chance
			item_base[| 1] = irandom_range(20 - (ilvl / 6), 30 - (ilvl / 6));	// innate shield recovery rate
			//item_base[| 2] = irandom_range(4 + ilvl, 4 + (4 * ilvl));			// armor deflection
		}
		else if (item[? "item_type"] == "Ammo")
		{
			item_sprite = spr_items_arrows;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			item_base[| 0] = irandom(12 + (6 * ilvl)); // projectile speed
			item_base[| 1] = irandom(10 + (6 * ilvl)); // projectile spread
		}
		else if (item[? "item_type"] == "Tome")
		{
			item_sprite = spr_items_tomes;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			item_base[| 0] = irandom(12 + (6 * ilvl)); // projectile speed
			item_base[| 1] = irandom(10 + (6 * ilvl)); // projectile spread
		}
		else if (item[? "item_type"] == "Helm")
		{
			item_sprite = spr_items_helms;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			item_base[| 0] = irandom_range(2 * ilvl, 12 + (6 * ilvl));
			item_base[| 1] = irandom_range(2 * ilvl, 12 + (6 * ilvl)); //FOR NOW THESE JUST ASSUME ONLY 1 ARMOR TYPE, THIS WILL NEED TO CHANGE
		}
		else if (item[? "item_type"] == "Chest Armor")
		{
			item_sprite = spr_items_chest_armor;//, spr_items_robes);
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			item_base[| 0] = irandom_range(2 * ilvl, 12 + (6 * ilvl));
			item_base[| 1] = irandom_range(2 * ilvl, 12 + (6 * ilvl)); //FOR NOW THESE JUST ASSUME ONLY 1 ARMOR TYPE, THIS WILL NEED TO CHANGE
		}
		else if (item[? "item_type"] == "Bracers")
		{
			item_sprite = spr_items_bracers;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			item_base[| 0] = irandom_range(2 * ilvl, 12 + (6 * ilvl));
			item_base[| 1] = irandom_range(2 * ilvl, 12 + (6 * ilvl)); //FOR NOW THESE JUST ASSUME ONLY 1 ARMOR TYPE, THIS WILL NEED TO CHANGE
		}
		else if (item[? "item_type"] == "Gloves")
		{
			item_sprite = choose(spr_items_gloves, spr_items_gauntlets);
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			item_base[| 0] = irandom_range(2 * ilvl, 12 + (6 * ilvl));
			item_base[| 1] = irandom_range(2 * ilvl, 12 + (6 * ilvl)); //FOR NOW THESE JUST ASSUME ONLY 1 ARMOR TYPE, THIS WILL NEED TO CHANGE
		}
		else if (item[? "item_type"] == "Belt")
		{
			item_sprite = spr_items_belts;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			item_base[| 0] = irandom_range(2 * ilvl, 12 + (6 * ilvl));
			item_base[| 1] = irandom_range(2 * ilvl, 12 + (6 * ilvl)); //FOR NOW THESE JUST ASSUME ONLY 1 ARMOR TYPE, THIS WILL NEED TO CHANGE
		}
		else if (item[? "item_type"] == "Greaves")
		{
			item_sprite = spr_items_greaves;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			item_base[| 0] = irandom_range(2 * ilvl, 12 + (6 * ilvl));
			item_base[| 1] = irandom_range(2 * ilvl, 12 + (6 * ilvl)); //FOR NOW THESE JUST ASSUME ONLY 1 ARMOR TYPE, THIS WILL NEED TO CHANGE
		}
		else if (item[? "item_type"] == "Boots")
		{
			item_sprite = spr_items_boots;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
			item_base[| 0] = irandom_range(2 * ilvl, 12 + (6 * ilvl));
			item_base[| 1] = irandom_range(2 * ilvl, 12 + (6 * ilvl)); //FOR NOW THESE JUST ASSUME ONLY 1 ARMOR TYPE, THIS WILL NEED TO CHANGE
		}
		else if (item[? "item_type"] == "Amulet")
		{
			item_sprite = spr_items_amulets;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
		}
		else if (item[? "item_type"] == "Ring")
		{
			item_sprite = spr_items_accessories;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
		}
		else if (item[? "item_type"] == "Cloak")
		{
			item_sprite = spr_items_cloaks;
			index = irandom_range(0, sprite_get_number(item_sprite) - 1);
		}
		
		// get random rarity for item
		var possible_rarities = ds_list_create();
		ds_list_add(possible_rarities, item_rarity_costs.common);
		ds_list_add(possible_rarities, item_rarity_costs.uncommon);
		ds_list_add(possible_rarities, item_rarity_costs.rare);
		ds_list_add(possible_rarities, item_rarity_costs.set);
		ds_list_add(possible_rarities, item_rarity_costs.unique);
		var item_rarity = possible_rarities[| irandom_range(0, ds_list_size(possible_rarities) - 1)];
		
		// get random health, damage, and stamina values for item
		var item_health = irandom_range(ilvl * (item_val / 100) * 0.5, ilvl * (item_val / 100) * 2.0);
		var item_damage = irandom_range(ilvl * (item_val / 100), ilvl * (item_val / 100) * 4.0);
		var item_stamina = irandom_range(ilvl * (item_val / 100) * 0.1, ilvl * (item_val / 100) * 0.4);
		
		// get the item's id #, which we can easily obtain by grabbing it's index in our global.items database
		var item_id = ds_list_size(global.items);
		
		
		// get random stats to populate the items with
		var item_stats = ds_list_create();
		var stats_used = ds_map_create();
		var num_stats;
		if (item_rarity == item_rarity_costs.common) num_stats = irandom_range(0, 1);
		else if (item_rarity == item_rarity_costs.uncommon) num_stats = irandom_range(1, 2);
		else if (item_rarity == item_rarity_costs.rare) num_stats = irandom_range(3, 4);
		else num_stats = irandom_range(4, 5);
		if (item[? "type"] == "accessory") num_stats += 1;
		if (ilvl > 20 && random(1.0) <= 0.5) num_stats += 1;
		if (ilvl > 50 && random(1.0) <= 0.4) num_stats += 1;
		if (ilvl > 80 && random(1.0) <= 0.2) num_stats += 1;
		
		for (var j = 0; j < num_stats; j++)
		{ 
			var rand_stat_num = irandom_range(0, ds_list_size(global.stat_list) - 1);
			var rand_stat = global.stat_list[| rand_stat_num];
			
			while (stats_used[? rand_stat] == true)
			{
				rand_stat_num = irandom_range(0, ds_list_size(global.stat_list) - 1);
				rand_stat = global.stat_list[| rand_stat_num];
			}
			
			var rand_stat_map = GenerateStat(rand_stat, ilvl);
			
			item_stats[| j] = rand_stat_map;
			stats_used[? rand_stat] = true;
		}
		
		
		// assign item's values to the item_map object 
		ds_map_add(item, "name", item_name);
		ds_map_add(item, "item_level", ilvl);
		ds_map_add(item, "value", item_val);
		ds_map_add(item, "rarity", item_rarity);
		ds_map_add(item, "sprite_index", item_sprite);
		ds_map_add(item, "description", "Just look at it. This item clearly warrants no description.");
		
		ds_map_add(item, "base_values", item_base);
		ds_map_add(item, "stats", item_stats);
		
		ds_map_add(item, "id", ds_list_size(global.items));
		ds_map_add(item, "image_index", index);
	
	
		ds_list_add(global.items, item);
		ds_list_add(level_items, item);
	
	}
	ds_map_add_list(global.loot_table, ilvl, level_items);
	
}

// PUT 24 RANDOM ITEMS INTO RANDOM SLOTS IN PLAYERS INVENTORY
repeat(24)
{
	var rand_slot = global.inventory[| irandom_range(0, ds_list_size(global.inventory) - 1)];
	var rand_item = global.items[| irandom_range(0, ds_list_size(global.items) - 1)];
	
	rand_slot[? "item_id"] = rand_item[? "id"];
}

// Mahogaknife
// Quill as magical weapon-- "The Power of the Written Word!"