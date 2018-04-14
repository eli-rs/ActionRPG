
// skill should either cost some stamina or should cost mana once implemented
//player_stamina_current -= player_ranged_attack_stamina_cost;
var skill_map = argument0;
var proj_map = skill_map[? "projectile"];

var num_projectiles = 18; // must be an odd number so that middle proj is aimed at cursor
// 0, 1, 2, --3--, 4, 5, 6

var offset_angle = 360 / num_projectiles;

for (var i = 0; i < num_projectiles; i++)
{

	var proj = instance_create_depth(x, y, depth - 1, obj_ranged_proj);
	var angle = i * offset_angle;

	var anim_speed = 0;
	
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
	
		proj_damage_range = obj_player.player_ranged_damage;
		proj_crit_chance = obj_player.player_crit_chance;
		proj_crit_mult = obj_player.player_crit_damage;
	}
}