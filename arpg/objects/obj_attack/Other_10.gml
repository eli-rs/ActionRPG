/// @description On-Hit Events


var pre_heal = obj_player.player_health_current;

obj_player.player_health_current = 
	min(global.player_stats[? derived_stats.life], 
	obj_player.player_health_current + global.player_stats[? derived_stats.life_per_hit]);
	
obj_player.player_mana_current = 
	min(global.player_stats[? derived_stats.mana], 
	obj_player.player_mana_current + global.player_stats[? derived_stats.mana_per_hit]);


var on_hit_skills = global.player_stats[? derived_stats.cast_skill_on_striking];
if (ds_list_size(on_hit_skills) > 0)
{
	for (var i = 0; i < ds_list_size(on_hit_skills); i++)
	{
		var skill_map = on_hit_skills[| i];
		var chance = skill_map[? "arg1"] / 100;
		var skill_level = skill_map[? "arg2"];
		var skill = skill_map[? "arg3"];
		if (random(1.0) <= chance)
		{
			script_execute(skill[? "script"], skill_level);
		}
	}
}

total_damage = irandom_range(damage_range[0], damage_range[1]);
if (random(1.0) <= crit_chance)
{
	total_damage = round(crit_mult * total_damage);
	was_crit = true;
}

var life_stolen = round((global.player_stats[? derived_stats.life_steal] / 100) * total_damage);

obj_player.player_health_current = 
	min(global.player_stats[? derived_stats.life], obj_player.player_health_current + life_stolen);
	
var mana_stolen = round((global.player_stats[? derived_stats.mana_steal] / 100) * total_damage);

obj_player.player_mana_current = 
	min(global.player_stats[? derived_stats.mana], obj_player.player_mana_current + mana_stolen);
	

var post_heal = obj_player.player_health_current;

