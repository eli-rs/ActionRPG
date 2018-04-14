image_speed = 1;

speed = random_range(0.7, 1.5);

tick_rate = 15; // how many steps per attack tick for whirlwind
tick_timer = 0;
duration = 30;
damage_range[0] = 16;
damage_range[1] = 32;
crit_chance = 0;
crit_mult = 1;
initial_direction = direction;
enemy_seeking_range = global.view_height / 2;
