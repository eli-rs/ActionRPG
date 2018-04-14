event_inherited();

image_speed = 1;
// ENEMY ATTRIBUTES, TESTING WITH VALUES CURRENTLY
//		BUT IN REAL GAME THESE VALUES SHOULD BE 'NOONE' 
//		AND SET PROGRAMATICALLY
//153 64 64

enemy_level = 3;
enemy_health_max = 972;
enemy_health_current = enemy_health_max;
enemy_speed = random_range(0.8, 2.6);

// ENEMY DETECTION & AWARENESS
enemy_detection_range = 0;
enemy_detection_range_back = 32;
enemy_detection_range_facing = global.view_height / 2;
enemy_has_detected_player = false;
enemy_detection_time = 30;
enemy_forget_time = game_get_speed(gamespeed_fps) * 4;
enemy_forget_timer = enemy_forget_time;
col_detection = make_color_rgb(153, 64, 64);



enemy_crit_chance = 0.08;
enemy_crit_damage = 1.5;

enemy_melee_range = 14;
enemy_within_melee_range = false;

// RANGED ATTRIBUTES
enemy_ranged_damage[0] = 15;
enemy_ranged_damage[1] = 42;

enemy_ranged_attack_reset_time = round(2 * game_get_speed(gamespeed_fps));
enemy_ranged_attack_timer = enemy_ranged_attack_reset_time;
enemy_melee_range = 16;
enemy_ranged_range = 128;
enemy_within_ranged_range = false;
enemy_can_ranged_attack = false;

enemy_projectile = spr_fireball_small;
enemy_projectile_speed = 4;


health_tracker = enemy_health_current;

// THESE VARIABLES GOVERN ENEMY'S WANDER BEHAVIOR
wander_duration = 0;
idle_time = 0;
init_x = x;
init_y = y;
leash_length = global.view_height / 2;
returning_home = false;

health_color = make_color_rgb(127, 25, 28);
health_color_dark = make_color_rgb(76, 15, 16);
health_color_light = make_color_rgb(178, 53, 55);

enemy_gold = irandom_range(0, enemy_level * 3);

enemy_loot = ds_list_create();

enemy_drop_level_ranges = ds_map_create();

var trash_range, common_range, uncommon_range, elite_range, boss_range;

trash_range[0] = -1;
trash_range[1] = 0;

common_range[0] = -2;
common_range[1] = 1;

uncommon_range[0] = -4;
uncommon_range[1] = 6;

elite_range[0] = -4;
elite_range[1] = 8;

boss_range[0] = -5;
boss_range[1] = 10;

enemy_drop_level_ranges[? enemy_types.trash] = trash_range;
enemy_drop_level_ranges[? enemy_types.common] = common_range;
enemy_drop_level_ranges[? enemy_types.uncommon] = uncommon_range;
enemy_drop_level_ranges[? enemy_types.elite] = elite_range;
enemy_drop_level_ranges[? enemy_types.boss] = boss_range;


enemy_rarity = enemy_types.trash;

enemy_experience_given = enemy_level * enemy_rarity;

#region Determine Loot Pool That Will Be Dropped by Enemy


enemy_loot_pool = irandom_range(0, enemy_level * enemy_rarity * 2);

if (enemy_loot_pool < item_rarity_costs.common) enemy_loot_pool = 0;
else
{
	var available_loot = ds_list_create();
	ds_list_add(available_loot, item_rarity_costs.common);
	ds_list_add(available_loot, item_rarity_costs.uncommon);
	ds_list_add(available_loot, item_rarity_costs.rare);
	ds_list_add(available_loot, item_rarity_costs.unique);
	ds_list_add(available_loot, item_rarity_costs.set);
	
	while (enemy_loot_pool >= item_rarity_costs.common)
	{
		if (enemy_loot_pool < item_rarity_costs.uncommon)
			ds_list_delete(available_loot, ds_list_find_index(available_loot, item_rarity_costs.uncommon))
		if (enemy_loot_pool < item_rarity_costs.rare)
			ds_list_delete(available_loot, ds_list_find_index(available_loot, item_rarity_costs.rare))
		if (enemy_loot_pool < item_rarity_costs.set)
			ds_list_delete(available_loot, ds_list_find_index(available_loot, item_rarity_costs.set))
		if (enemy_loot_pool < item_rarity_costs.unique)
			ds_list_delete(available_loot, ds_list_find_index(available_loot, item_rarity_costs.unique));
		
		var random_loot = available_loot[| irandom_range(0, ds_list_size(available_loot) - 1)];
		ds_list_add(enemy_loot, random_loot);
		enemy_loot_pool -= random_loot;
	}
}

enemy_level_range = enemy_drop_level_ranges[? enemy_rarity];
loot_to_drop = ds_list_create();

for (var i = 0; i < ds_list_size(enemy_loot); i++)
{
	var rarity = enemy_loot[| i];
	var level = max(1, irandom_range(enemy_level + enemy_level_range[0], enemy_level + enemy_level_range[1]));
	
	for (var index = 0; index < ds_map_size(global.loot_table[? level]); index ++)
	{
		var level_table = global.loot_table[? level];
		var entry = level_table[| index];
		if (entry[? "rarity"] == rarity)
		{
			ds_list_add(loot_to_drop, entry);
		}
	}
}
#endregion


















