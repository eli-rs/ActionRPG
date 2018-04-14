isInteracting = false;
interactingWithID = noone;

image_speed = 0;
is_deflecting = false;
deflect_angle = 0;
deflect_frame = 0;

is_dodging = false;
dodge_frame = 1;

is_hurt = false;

absorbing = -1;
absorbed_damage = ds_list_create();
absorption_base_duration = 10;
for (var i = 0; i < absorption_base_duration; i++)
	absorbed_damage[| i] = 0;

player_level = 1;
player_experience_needed = 140;
player_experience_current = 0;

player_strength = 6;
player_dexterity = 6;
player_constitution = 6;
player_intelligence = 6;

player_currency = 110;

//====================MOVEMENT VARIABLES
maxSpeed = player_dexterity / 2;
horizSpeed = 0;
vertSpeed = 0;
accelSpeed = player_dexterity / 8;

isDashing = false;
canDash = true;
dashTime = 8; //time in frames
dashTimer = dashTime;
dashSpeed = player_dexterity / 3;
dashResetTime = (2 / player_dexterity) * game_get_speed(gamespeed_fps); //time in seconds
dashResetTimer = dashResetTime;

dash_stamina_cost = (player_dexterity / 2) + (player_constitution / 2);

player_potion_reset_time = 5 * game_get_speed(gamespeed_fps);
player_potion_reset_timer = player_potion_reset_time;
health_potion_value = 35;

//=====================PLAYER ATTRIBUTES
player_health_base = 100;
player_health_max = player_level * (60 + (4 * player_constitution) + sqr(player_constitution));
player_health_current = global.player_stats[? derived_stats.life];

player_health_changed = player_health_current;
player_health_back_current = player_health_current;
animating_health_time = 20;
animating_health_frame = 0;

player_mana_base = 70;
player_mana_current = global.player_stats[? derived_stats.mana];
player_stamina_base = 50;


player_stamina_max = 20 + (5 * player_constitution);
player_stamina_current = player_stamina_max;

player_stamina_accel_const = 10;
player_stamina_rate = 0.1; // roughly 8 stam per second

// all items that modify attack rate, ie [6%, 11%, 4%, 15%] are multiplied together
//		i.e. 1.06 * 1.11 * 1.04 * 1.15, to get attackrate buff, = 1.395
//		thus final attackspeed = base * 1.395 = 15 * 1.395 = 10.75 frames per atk
//		which translates to roughly 3 attacks per second
can_melee_attack = true;
is_melee_attacking = false;
//player_attack_rate_base = 1 * game_get_speed(gamespeed_fps);
player_melee_attack_reset_time = ceil(100 / (player_dexterity + player_strength));//(1/30) * game_get_speed(gamespeed_fps);
player_melee_attack_timer = player_melee_attack_reset_time;

player_melee_attack_stamina_cost = 20 - player_constitution - (player_strength / 2);
player_melee_damage[0] = 240;
player_melee_damage[1] = 319;
player_hitbox = spr_slash_medium;
swap_directions = true;

player_crit_chance = 0.18;
player_crit_damage = 2.14;


player_swing_rate = 1;
player_shoot_rate = 1;
player_cast_rate = 1;

can_ranged_attack = true;
is_ranged_attacking = false;

player_ranged_attack_stamina_cost = 20 - player_constitution - (player_dexterity / 2);;
player_ranged_damage[0] = 144;
player_ranged_damage[1] = 244;
player_ranged_attack_reset_time = ceil(100 / (2 * player_dexterity)); //0.6 * game_get_speed(gamespeed_fps);
player_ranged_attack_timer = player_ranged_attack_reset_time;
player_proj_speed = 2 * player_dexterity;
animating_bow = true;
bow_frame = 0;

player_skill_levels = ds_list_create();
player_skill_levels[| 0] = 12;
player_skill_levels[| 1] = 12;
player_skill_levels[| 2] = 12;


global.fx_system_3 = part_system_create_layer("Layer_Objects", true);
global.fx_emitter_3 = part_emitter_create(global.fx_system_3);


light_x = 0;
light_y = 0;
col_shadow = make_color_rgb(39, 32, 52);

UpdateStats();
player_health_current = global.player_stats[? derived_stats.life];