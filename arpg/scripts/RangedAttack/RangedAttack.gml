
var proj = instance_create_layer(x, y, "Layer_Objects", obj_ranged_proj_enemy);
proj.sprite_index = enemy_projectile;

// set the hit_box angle toward where clicked
proj.image_angle = point_direction(x, y, obj_player.x, obj_player.y);
proj.direction = proj.image_angle;
proj.image_speed = 1;
// set the hitbox damage and other player_given variables
proj.damage_range = enemy_ranged_damage;
proj.crit_chance = enemy_crit_chance;
proj.crit_mult = enemy_crit_damage;
proj.speed = enemy_projectile_speed;
proj.is_piercing = false;