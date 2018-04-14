event_inherited();
/*
if (! ds_map_exists(unique_collisions, other))
{
	ds_map_add(unique_collisions, other, true);
	
	
	//part_system_position(global.fx_system_1, x, y)
	//part_emitter_burst(global.fx_system_1, global.fx_emitter_1, global.particle_1, 6);
	
	var total_damage = irandom_range(proj_damage_range[0], proj_damage_range[1]);
	var was_crit = false;
	if (random(1.0) <= proj_crit_chance)
	{
		total_damage = round(proj_crit_mult * total_damage);
		was_crit = true;
	}
	
	other.player_health_current -= total_damage;

	if (is_piercing = false)
		instance_destroy();
		
	// offset the popup text's x and y positions to accomodate the sprite
	text_x = other.x;
	if (other.sprite_index == spr_enemy_glomper) text_x += 4;
	else if (other.sprite_index == spr_enemy_glomper_left) text_x -= 4;
	
	text_y = other.y - (other.sprite_height * (2/3));
	// INSTANTIATE THE POPUP TEXT OBJECT AT THE PROPER POSITION
	var text_obj = instance_create_layer(text_x, text_y, "Layer_Objects", obj_damage_text_enemy);
	text_obj.damage = total_damage;
	text_obj.was_crit = was_crit;
}*/
