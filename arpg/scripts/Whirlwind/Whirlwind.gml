
// skill should either cost some stamina or should cost mana once implemented
//player_stamina_current -= player_ranged_attack_stamina_cost;

//duration, dmg range, seeking range, attack speed
var skill_level = argument0;
var tornado_obj = obj_wandering_storm;

var skill_damage;
skill_damage[0] = (skill_level * 3) / 2;
skill_damage[1] = (skill_level * 3);
var atk_dmg = global.player_stats[? derived_stats.spell_damage];
skill_damage[0] += atk_dmg[0];
skill_damage[1] += atk_dmg[1];


var storm = instance_create_depth(x, y, depth - 1, tornado_obj);
storm.initial_direction = point_direction(x, y, mouse_x, mouse_y);
storm.direction = storm.initial_direction;
storm.damage_range = skill_damage;
storm.duration = (4 + (skill_level / 2)) * game_get_speed(gamespeed_fps);
storm.crit_chance = global.player_stats[? derived_stats.critical_hit_chance];
storm.crit_mult = global.player_stats[? derived_stats.critical_hit_damage];
storm.tick_rate = game_get_speed(gamespeed_fps) - skill_level;



