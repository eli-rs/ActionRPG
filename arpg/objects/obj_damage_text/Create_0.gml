initial_y = y;

damage = 0;
was_crit = false;

grav_accel = 1.8; //the amount of speed lost per frame
fade_rate = 0.015;

vert_speed = irandom_range(5, 10);
horiz_speed = choose(random_range(-4, -2), random_range(2, 4));
alpha = 1;

color_normal = make_color_rgb(204, 187, 141);
color_crit = make_color_rgb(255, 119, 0);