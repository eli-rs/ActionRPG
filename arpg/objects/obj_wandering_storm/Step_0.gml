
duration -= 1;
if (tick_timer > 0)
	tick_timer -= 1;

enemies_within_range = InstancesWithinRange(x, y, enemy_seeking_range, obj_enemy);
var num_enemies = ds_list_size(enemies_within_range);
if (num_enemies > 0)
{
	var closest = enemies_within_range[| 0];
	direction = point_direction(x, y, closest.x, closest.y);
}

direction += irandom_range(0, irandom_range(-15, 15));

if (duration <= 0)
	instance_destroy();