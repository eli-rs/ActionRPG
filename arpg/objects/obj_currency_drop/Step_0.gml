
if (landed == false && y >= end_y && just_created == false)
{
	landed = true;
}

if (landed = false)
{
	x += horiz_speed;
	y -= vert_speed;

	vert_speed -= grav_accel;
	just_created = false;
}

if (landed = true && point_distance(x, y, obj_player.x, obj_player.y) <= pickup_radius)
{
	move_towards_point(obj_player.x, obj_player.y, 4);
	x += 0.15 * (obj_player.x - x);
	y += 0.2 * (obj_player.y - y);
}

if (point_distance(x, y, obj_player.x, obj_player.y) <= destroy_radius)
{
	instance_destroy();
}