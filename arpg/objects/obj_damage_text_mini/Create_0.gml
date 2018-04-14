initial_y = y;

damage = 0;
was_crit = false;

grav_accel = 1.2; //the amount of speed lost per frame
fade_rate = 0.015;

vert_speed = 5;
horiz_speed = choose(random_range(-2, -1), random_range(1, 2));
alpha = 1;

color_normal = c_red; 