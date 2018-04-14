// clean up after our particle systems
part_system_destroy(global.fx_system_1);
part_system_destroy(global.fx_system_2);
part_system_destroy(global.fx_system_3);
/*
for (var i = 0; i < ds_list_size(item_particles_to_destroy); i++)
	part_system_destroy(item_particles_to_destroy[| i]);
*/
ds_list_destroy(global.items);
ds_list_destroy(global.equipment);
ds_map_destroy(global.loot_table);
ds_list_destroy(global.inventory);
ds_list_destroy(global.projectiles);
ds_list_destroy(global.particles);
ds_list_destroy(global.player_skills);
ds_list_destroy(global.player_stats);