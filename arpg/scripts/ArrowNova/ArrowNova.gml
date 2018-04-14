
// skill should either cost some stamina or should cost mana once implemented
//player_stamina_current -= player_ranged_attack_stamina_cost;
var skill_level = argument0;
var proj_map = global.projectiles[| 0];

var num_projectiles = 12 + skill_level; 
// 0, 1, 2, --3--, 4, 5, 6
var skill_damage;
skill_damage[0] = (skill_level * 6) / 2;
skill_damage[1] = (skill_level * 6);
var atk_dmg = global.player_stats[? derived_stats.attack_damage];
skill_damage[0] += atk_dmg[0];
skill_damage[1] += atk_dmg[1];

var offset_angle = 360 / num_projectiles;

for (var i = 0; i < num_projectiles; i++)
{

	var proj = instance_create_depth(x, y, depth - 1, obj_ranged_proj);
	var angle = i * offset_angle;

	var anim_speed = 0;
	
	with (proj)
	{
		triggered_by_skill = true;
		image_speed = anim_speed;
		image_angle = angle;
		sprite_index = proj_map[? "sprite_index"];
		image_index = proj_map[? "image_index"];
		if (sprite_index == spr_projectiles) image_angle += 45;
		direction = angle;
		speed = proj_map[? "speed"];

		enemies_pierced = proj_map[? "piercing"];
		is_spinning = proj_map[? "spinning"];
		is_swinging = proj_map[? "swinging"];
		if (is_swinging) pivot_point = proj_map[? "origin"];
	
		damage_range = skill_damage;
		crit_chance = global.player_stats[? derived_stats.critical_hit_chance];
		crit_mult = global.player_stats[? derived_stats.critical_hit_damage];
	}
}