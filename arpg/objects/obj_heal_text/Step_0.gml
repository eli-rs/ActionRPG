
if (alpha <= 0)
	instance_destroy();

if (alpha <= 0.85) fade_rate = 0.05;

x += horiz_speed;
y -= vert_speed;

alpha -= fade_rate;
