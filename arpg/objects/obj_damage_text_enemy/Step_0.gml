
if (alpha <= 0)
	instance_destroy();

if (alpha != 1 && y >= initial_y)
	fade_rate = 0.13

x += horiz_speed;
y -= vert_speed;

vert_speed -= grav_accel;
alpha -= fade_rate;
