event_inherited();

/*
unique_collisions = ds_map_create();
proj_damage_range[0] = 0;
proj_damage_range[1] = 1;
proj_crit_chance = 0;
proj_crit_mult = 0;
enemies_pierced = 0;
*/

image_speed = 0;

// projectile behaviors while flying
is_spinning = false;
is_swinging = false;
pivot_point = 0; //pivot closer to center means less swing, negative pivot means rly wide swing



distance_traveled = 0;
max_distance = global.view_width;


