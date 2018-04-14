// the radius within spawner the player has to come for spawner to activate
trigger_radius = global.view_width * 2;
// the radius within which the spawner will spawn enemies
spawn_radius = global.view_height / 2;

possible_spawns = ds_list_create();
possible_spawns[| 0] = obj_enemy_melee;
//possible_spawns[| 1] = obj_enemy_ranged;
//possible_spawns[| 2] = obj_enemy_beldaan;

spawner_level_range[0] = max(1, obj_player.player_level - 2);
spawner_level_range[1] = obj_player.player_level;

num_spawns_range[0] = 2;
num_spawns_range[1] = 5;

has_triggered = false;