
global.projectiles = ds_list_create();
//=================== PROJECTILE TYPES
player_projectile_arrow = ds_map_create();
player_projectile_arrow[? "sprite_index"] = spr_projectiles;
player_projectile_arrow[? "image_index"] = 0;
player_projectile_arrow[? "spinning"] = false;
player_projectile_arrow[? "piercing"] = 5;
player_projectile_arrow[? "speed"] = 15;
player_projectile_arrow[? "swinging"] = false;
player_projectile_arrow[? "origin"] = noone; //0 is topleft of sprite, negative means wide swing
global.projectiles[| 0] = player_projectile_arrow;
//ds_map_destroy(player_projectile_arrow);

player_projectile_boomerang = ds_map_create();
player_projectile_boomerang[? "sprite_index"] = spr_projectiles;
player_projectile_boomerang[? "image_index"] = 9;
player_projectile_boomerang[? "spinning"] = true;
player_projectile_boomerang[? "piercing"] = 2;
player_projectile_boomerang[? "speed"] = 5;
player_projectile_boomerang[? "swinging"] = true;
player_projectile_boomerang[? "origin"] = 0; //0 is topleft of sprite, negative means wide swing
global.projectiles[| 1] = player_projectile_boomerang;
//ds_map_destroy(player_projectile_boomerang);

player_projectile_shuriken = ds_map_create();
player_projectile_shuriken[? "sprite_index"] = spr_projectiles;
player_projectile_shuriken[? "image_index"] = 8;
player_projectile_shuriken[? "spinning"] = true;
player_projectile_shuriken[? "speed"] = 4;
player_projectile_shuriken[? "piercing"] = 0;
player_projectile_shuriken[? "swinging"] = false;
player_projectile_shuriken[? "origin"] = noone; //0 is topleft of sprite, negative means wide swing
global.projectiles[| 2] = player_projectile_shuriken;
//ds_map_destroy(player_projectile_shuriken);

