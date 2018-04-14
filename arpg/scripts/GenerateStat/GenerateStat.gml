///@param stat
///@param item_level

var _stat = argument0;
var _item_level = argument1;

var orig_map = global.stat_maps[? _stat];

var _stat_map = ds_map_create();
_stat_map[? "num_arguments"] = orig_map[? "num_arguments"];


for (var t = 1; t < _stat_map[? "num_arguments"] + 1; t ++)
{
	var key = "arg" + string(t);
	ds_map_add(_stat_map, key, 0);
}

ds_map_add(_stat_map, "stat", _stat);
			

if (_stat == stats.cast_skill_on_striking || _stat == stats.cast_skill_when_struck)
{
	var chance = irandom_range(2, 12) + irandom_range( max(1, _item_level / 5), max(1, _item_level / 2 ));
	var skill_level = clamp(irandom(_item_level / 3), 1, 20);
	var skill = global.player_skills[| irandom_range(0, ds_list_size(global.player_skills) - 1)];
	_stat_map[? "arg1"] = chance;
	_stat_map[? "arg2"] = skill_level;
	_stat_map[? "arg3"] = skill;
				
}
else if (_stat == stats.immunity_to_status_effect)
{
	var s_num = irandom_range(0, ds_list_size(global.status_effects) - 1);
	var rand_status = global.status_effects[| s_num];
	_stat_map[? "arg1"] = rand_status;
}
else if (_stat == stats.specific_skill)
{
	_stat_map[? "arg1"] = max(1, irandom_range(0, _item_level / 10));
	_stat_map[? "arg2"] = global.player_skills[| irandom_range(0, ds_list_size(global.player_skills) - 1)];
}
else if (_stat == stats.class_skill_tree)
{ 
	var tree_names = ["Pyromancy", "Fletching", "Doom", "Martial Law", "Piracy", "Transformative", "Tantric"];
	var amount = max(1, floor(irandom_range(0, _item_level / 15)));
	_stat_map[? "arg1"] = amount;
	_stat_map[? "arg2"] = tree_names[irandom_range(0, array_length_1d(tree_names)-1)];
}
else if (_stat == stats.class_skills)
{
	var class_names = ["Gladiator", "Huntress", "Archon", "Miscreant", "Mage", "Assassin", "Templar"];
	var amount = max(1, floor(irandom_range(0, _item_level / 20)));
	_stat_map[? "arg1"] = amount;
	_stat_map[? "arg2"] = class_names[irandom_range(0, array_length_1d(class_names)-1)];
}
else if (_stat == stats.all_skills)
{
	var amount = max(1, floor(irandom_range(0, _item_level / 30)));
	_stat_map[? "arg1"] = amount;
}
else if (_stat == stats.reduced_duration_to_status_effect)
{
	var s_num = irandom_range(0, ds_list_size(global.status_effects) - 1);
	_stat_map[? "arg1"] = irandom_range(10, 10 + _item_level);
	var rand_status = global.status_effects[| s_num];
	_stat_map[? "arg2"] = rand_status;
}
else if (_stat == stats.damage_to_attacks || _stat == stats.damage_to_spells)
{
	var dmg_avg = irandom_range(_item_level * 2, _item_level * 4);
	var dmg_min = irandom_range(1, dmg_avg);
	var dmg_max = irandom_range(1, dmg_avg * 2);
	_stat_map[? "arg1"] = min(dmg_min, dmg_max);
	_stat_map[? "arg2"] = max(dmg_min, dmg_max);
}
else if (_stat == stats.more_critical_hit_chance || _stat == stats.more_critical_hit_damage)
{
	_stat_map[? "arg1"] = max(1, irandom_range(_item_level / 5, _item_level / 2));
}
else
{
	for (var k = 1; k <= _stat_map[? "num_arguments"]; k++)
	{
		var arg = "arg" + string(k);
		_stat_map[? arg] = ceil(_item_level / 5) + irandom_range(_item_level / 2, _item_level * 2);
	}
				
}

return _stat_map;