
var angle_to_player = point_direction(x, y, obj_player.x, obj_player.y);

var x_diff = obj_player.x - x;
var y_diff = obj_player.y - y;
	
var magnitude = sqrt(sqr(x_diff) + sqr(y_diff));
var norm_x = x_diff / magnitude;
var norm_y = y_diff / magnitude;
	
var x_mult = name == "spr_ogre_blue" ? sprite_width / 4 : sprite_width / 2;
var y_mult = sprite_height / 2;
	
// we also add the player speed to the position to account for player's movement while 
// the hitbox animation is playing
var hitbox_frames = sprite_get_number(enemy_hitbox);

var hitbox_x = x + (norm_x * x_mult);// + (horizSpeed * hitbox_frames);
var hitbox_y = y + (norm_y * y_mult);// + (vertSpeed * hitbox_frames);
	
	
var hit_box = instance_create_layer(hitbox_x, hitbox_y, "Layer_Objects", obj_hitbox_enemy);

hit_box.sprite_index = enemy_hitbox;
// set the hit_box angle toward where clicked
hit_box.image_angle = angle_to_player;
// set the hitbox damage and other player_given variables
hit_box.enemy_id = id;
hit_box.level = enemy_level;
hit_box.accuracy = enemy_accuracy;
hit_box.damage_range = enemy_melee_damage;
hit_box.crit_chance = enemy_crit_chance;
hit_box.crit_mult = enemy_crit_damage;