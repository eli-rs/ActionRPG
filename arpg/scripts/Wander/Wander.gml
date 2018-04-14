
// if our wander duration has elapsed, pick a new direction and time to wander in/for
var dist_from_origin = point_distance(x, y, init_x, init_y);
if (dist_from_origin >= leash_length || returning_home)
{
	direction = point_direction(x, y, init_x, init_y);
	speed = enemy_speed / 2;
	returning_home = true;
	if (dist_from_origin <= 12) returning_home = false;
}
else
{
	if (wander_duration <= 0)
	{
		idle_time = irandom_range(0, 150)
		wander_duration = irandom_range(30, 120) + idle_time;
		direction = direction + irandom_range(-90, 90);
		speed = enemy_speed / 2;
	}
	else
	{
		if (wander_duration <= idle_time) speed = 0;

		wander_duration -= 1;
	}
}