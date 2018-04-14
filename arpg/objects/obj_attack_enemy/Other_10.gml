/// @description When-Player-Struck Events

var when_struck_skills = global.player_stats[? derived_stats.cast_skill_when_struck];
if (ds_list_size(when_struck_skills) > 0)
{
	for (var i = 0; i < ds_list_size(when_struck_skills); i++)
	{
		var skill_map = when_struck_skills[| i];
		var chance = skill_map[? "arg1"] / 100;
		var skill_level = skill_map[? "arg2"];
		var skill = skill_map[? "arg3"];
		if (random(1.0) <= chance)
		{
			script_execute(skill[? "script"], skill_level);
		}
	}
}

