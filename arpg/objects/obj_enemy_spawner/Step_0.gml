
if (point_distance(x, y, obj_player.x, obj_player.y) <= trigger_radius)
{
	var number_of_enemies = irandom_range(num_spawns_range[0], num_spawns_range[1]);
	for (var num = 0; num < number_of_enemies; num++)
	{
		var enemy_level = irandom_range(spawner_level_range[0], spawner_level_range[1]);
		var enemy_x = irandom_range(x - spawn_radius, x + spawn_radius);
		var enemy_y = irandom_range(y - spawn_radius, y + spawn_radius);
		var enemy_type = possible_spawns[| irandom_range(0, ds_list_size(possible_spawns) - 1)];
		var enemy = instance_create_depth(enemy_x, enemy_y, depth - 2, enemy_type);
	}
	has_triggered = true;
	instance_destroy();
}