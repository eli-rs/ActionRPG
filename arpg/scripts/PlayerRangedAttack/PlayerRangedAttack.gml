

player_stamina_current -= player_ranged_attack_stamina_cost;
	
var proj = instance_create_depth(x, y + 5, depth - 1, obj_ranged_proj);
var angle = point_direction(x, y, mouse_x, mouse_y);
var proj_map = global.projectiles[| 0];
if (proj_map == global.projectiles[| 0]) animating_bow = true;
var anim_speed = 0;
//if (player_ranged_hitbox == spr_projectiles)
	//anim_speed = 0;
with (proj)
{
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
	damage_range = global.player_stats[? derived_stats.attack_damage];
	crit_chance = global.player_stats[? derived_stats.critical_hit_chance];
	crit_mult = global.player_stats[? derived_stats.critical_hit_damage];
	
	
}