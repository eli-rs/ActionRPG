
// AFTER FINISHING IN THE LEVELUP SCREEN WE NEED TO RESET THE APPROPRIATE LEVELUP VARIABLES FOR USE NEXT TIME WE LEVEL UPdd
var size = 3;
for (var i = 0; i < ds_grid_height(attr_grid); i++)
{
	for (var j = 0; j < ds_grid_width(attr_grid); j++)
	{
		if (j == 0)
			attr_grid[# i, j] = 1;
		else
			attr_grid[# i, j] = 0;
	}
}
display_warning = false;
attribute_points = size;
clicked_spend = false;

//====================MOVEMENT VARIABLES
with(obj_player)
{

maxSpeed = obj_player.player_dexterity  / 2;
accelSpeed = obj_player.player_dexterity  / 8;


dashTime = round(1.5 * obj_player.player_dexterity ); //time in frames
dashSpeed = obj_player.player_dexterity  / 3;
dashResetTime = (2 / obj_player.player_dexterity ) * game_get_speed(gamespeed_fps); //time in seconds
dash_stamina_cost = (obj_player.player_dexterity  / 2) + (obj_player.player_constitution / 2);

//=====================PLAYER ATTRIBUTES
player_health_max = player_level * (60 + (4 * obj_player.player_constitution) + sqr(obj_player.player_constitution));
player_health_current = player_health_max;

player_stamina_max = 20 + (5 * obj_player.player_constitution);
player_stamina_current = player_stamina_max;

player_stamina_accel_const = 10;
player_stamina_rate = 0.1; // roughly 8 stam per second

// all items that modify attack rate, ie [6%, 11%, 4%, 15%] are multiplied together
//		i.e. 1.06 * 1.11 * 1.04 * 1.15, to get attackrate buff, = 1.395
//		thus final attackspeed = base * 1.395 = 15 * 1.395 = 10.75 frames per atk
//		which translates to roughly 3 attacks per second

//player_attack_rate_base = 1 * game_get_speed(gamespeed_fps);
player_melee_attack_reset_time = ceil(100 / (obj_player.player_dexterity  + obj_player.player_strength));

player_melee_attack_stamina_cost = 20 - obj_player.player_constitution - (obj_player.player_strength / 2);
player_melee_damage[0] = 240;
player_melee_damage[1] = 319;

player_crit_chance = 0.18;
player_crit_damage = 2.14;

player_swing_rate = 1;
player_shoot_rate = 1;
player_cast_rate = 1;

player_ranged_attack_stamina_cost = 20 - obj_player.player_constitution - (obj_player.player_dexterity  / 2);;
player_ranged_damage[0] = 640;
player_ranged_damage[1] = 878;
player_ranged_attack_reset_time = ceil(100 / (2 * obj_player.player_dexterity )); //0.6 * game_get_speed(gamespeed_fps);
player_proj_speed = 2 * obj_player.player_dexterity ;
}