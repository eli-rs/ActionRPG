
// this script should run exclusively when an item in the equipment panel changes:
// i.e. [Player Equips New Item], [Player Unequips Old Item], [Player Switches Old Item with New Item]

var equipping_item = argument0; // TRUE if EQUIPPED, FALSE if UNEQUIPPED
var item_map = argument1;

//// CURRENTLY THIS SCRIPT WORKS ONLY FOR ADDING NEW ITEMS TO EQUIPMENT, NEED TO ADD TO SCRIPT
//		SO THAT IT ACCOUNTS FOR WHEN AN ITEM IS TAKEN AWAY. 
//		PERHAPS DO THIS: ANY ITEM IS ADDED, ADD ALL STATS TO ALL CURRENT STATS (LIKE BELOW)
//						 ANY ITEM IS REMOVED, GET ALL STATS FOR THAT ITEM AND SUBTRACT THEM FROM ALL APPROPRIATE STATS
// 
//		THAT WAY WE DONT NEED TO ACTUALLY KEEP TRACK OF WHICH STATS COME FROM WHICH ITEMS, WE CAN JUST ADD/SUBTRACT EVERY TIME THEY CHANGE

var base_stats = item_map[? "base_values"];

var item_stats = item_map[? "stats"];

if (item_map[? "base_type"] == "armor")
{
	var deflect = obj_character_sheet.stat_bible[? stats.armor_deflection];
	var absorb = obj_character_sheet.stat_bible[? stats.armor_absorption];
	if (equipping_item)
	{
		deflect[? "arg1"] += base_stats[| 0];
		absorb[? "arg1"] += base_stats[| 1];
	}
	else
	{
		deflect[? "arg1"] -= base_stats[| 0];
		absorb[? "arg1"] -= base_stats[| 1];
	}
}

// ELSE: IF SHIELD: CHANGE RECOVERYTIME&BLOCKCHANCE


for (var j = 0; j < ds_list_size(item_stats); j++)
{
	var stat_map = item_stats[| j];
	var stat = stat_map[? "stat"];
	var current_stat = obj_character_sheet.stat_bible[? stat];
	
	if (equipping_item)
	{
		// if the stat in question only carries an amount (whether flat or percent) then just add it
		if (stat == stats.immunity_to_status_effect || stat == stats.reduced_duration_to_status_effect ||
			stat == stats.cast_skill_on_striking || stat == stats.cast_skill_when_struck || stat == stats.class_skills ||
			stat == stats.class_skill_tree || stat == stats.specific_skill)
		{
			ds_list_add(current_stat, stat_map);
		}
		else if (stat_map[? "num_arguments"] == 1 )
		{
			current_stat[? "arg1"] += stat_map[? "arg1"];
		}
		else if (stat == stats.damage_to_attacks || stat == stats.damage_to_spells)
		{
			current_stat[? "arg1"] += stat_map[? "arg1"];
			current_stat[? "arg2"] += stat_map[? "arg2"];
		}
	}
	else
	{
		// if the stat in question only carries an amount (whether flat or percent) then just add it
		if (stat == stats.immunity_to_status_effect || stat == stats.reduced_duration_to_status_effect ||
			stat == stats.cast_skill_on_striking || stat == stats.cast_skill_when_struck || stat == stats.class_skills ||
			stat == stats.class_skill_tree || stat == stats.specific_skill)
		{
			
			for (var i = 0; i < ds_list_size(current_stat); i++)
			{
				var entry_map = current_stat[| i];
				var num_args = entry_map[? "num_arguments"];
				var all_args_equal = true;
				
				for (var arg = 1; arg <= num_args; arg ++)
				{
					var key = "arg" + string(arg);
					if (entry_map[? key] != stat_map[? key])
					{
						all_args_equal = false;
						break;
					}
				}
				if (all_args_equal)
				{
					ds_list_delete(current_stat, i);
					break;
				}
			}
		}
		else if (stat_map[? "num_arguments"] == 1 )
		{
			current_stat[? "arg1"] -= stat_map[? "arg1"];
		}
		else if (stat == stats.damage_to_attacks || stat == stats.damage_to_spells)
		{
			current_stat[? "arg1"] -= stat_map[? "arg1"];
			current_stat[? "arg2"] -= stat_map[? "arg2"];
		}
	}

}
	
UpdateStats();