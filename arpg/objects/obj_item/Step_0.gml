/*
part_system_position(global.systems[| emitter_num], x + (sprite_width / 2), y + (sprite_height / 2));
if (! particles_made)
{
	particles_made = true;
	var i = global.items[| item_id];
	var rarity = i[? "rarity"];
	
	if (global.settings[? "item_burst_particles"] == true)
	{
		
		
		var p_type;
		if (rarity == item_rarity_costs.common)
			p_type = global.item_particles_common;
		else if (rarity == item_rarity_costs.uncommon)
			p_type = global.item_particles_uncommon;
		else if (rarity == item_rarity_costs.rare)
			p_type = global.item_particles_rare;
		else if (rarity == item_rarity_costs.set)
			p_type = global.item_particles_set;
		else if (rarity == item_rarity_costs.unique)
			p_type = global.item_particles_unique;
		
		var num_particles = 10;
		if (rarity == item_rarity_costs.rare) num_particles = 13;
		else if (rarity == item_rarity_costs.set || rarity == item_rarity_costs.unique) num_particles = 18;
		part_emitter_stream(global.systems[| emitter_num], global.emitters[| emitter_num], 
			p_type, num_particles);
	}
}*/
if (aura_created)
{
	if (aura_idx >= sprite_get_number(aura_sprite) - 1)
		aura_decreasing = true;
	else if (aura_idx == 0) 
		aura_decreasing = false;
		
	if (aura_decreasing == false)
		aura_idx += 0.5;
	else
		aura_idx -= 0.5;
}

#region Make the Items Popup on Spawn, Stop them on Landing
if (landed == false && y >= end_y && just_created == false)
{
	landed = true;
}

if (landed == false)
{
	x += horiz_speed;
	y -= vert_speed;

	vert_speed -= grav_accel;
	
	var diff = 0 - horiz_speed;
	horiz_speed += 0.1 * diff;

	just_created = false;
}
#endregion


if (landed && aura_created = false)
{
	var i = global.items[| item_id];
	var rarity = i[? "rarity"];
	if (global.settings[? "item_burst_particles"] == true)
	{
		
		
		var p_type;
		if (rarity == item_rarity_costs.common)
			p_type = global.item_particles_common;
		else if (rarity == item_rarity_costs.uncommon)
			p_type = global.item_particles_uncommon;
		else if (rarity == item_rarity_costs.rare)
			p_type = global.item_particles_rare;
		else if (rarity == item_rarity_costs.set)
			p_type = global.item_particles_set;
		else if (rarity == item_rarity_costs.unique)
			p_type = global.item_particles_unique;
		
		var num_particles = 8;
		if (rarity == item_rarity_costs.rare) num_particles = 10;
		else if (rarity == item_rarity_costs.set || rarity == item_rarity_costs.unique) num_particles = 20;
		part_system_position(global.systems[| emitter_num], x + (sprite_width / 2), y + (sprite_height / 2));
		part_emitter_stream(global.systems[| emitter_num], global.emitters[| emitter_num], 
			p_type, num_particles);
	}
	aura_created = true;
	
	
	if (rarity == item_rarity_costs.common)	
	{
		aura_sprite = spr_item_aura_common;
		aura_alpha = 0.4;
	}
	else if (rarity == item_rarity_costs.uncommon)
	{
		aura_sprite = spr_item_aura_uncommon;
		aura_alpha = 0.5;
	}
	else if (rarity == item_rarity_costs.rare)
	{
		aura_sprite = spr_item_aura_rare;
		aura_alpha = 0.6;
	}
	else if (rarity == item_rarity_costs.unique)
	{
		aura_sprite = spr_item_aura_unique;
		aura_alpha = 0.8;
	}
	else if (rarity == item_rarity_costs.set)
	{
		aura_sprite = spr_item_aura_set;
		aura_alpha = 0.8;
	}
}
	


if (isInteracting && landed)
{
	var next_slot = GetNextInventorySlot();

	if (next_slot != noone)
	{
		var slot_map = global.inventory[| next_slot];
		ds_map_set(slot_map, "item_id", item_id);
		ds_list_set(global.inventory, next_slot, slot_map);
		
		obj_player.isInteracting = false;
		obj_player.interactingWithID = noone;
		
		
		var i = global.items[| item_id];
		var rarity = i[? "rarity"];
		var col_particles = c_white;
		var num_particles = 20;
		if (rarity == item_rarity_costs.uncommon){
			num_particles = 30;
			col_particles = c_yellow;
		}
		if (rarity == item_rarity_costs.rare){ 
			num_particles = 70;
			col_particles = c_teal;
		}
		else if (rarity == item_rarity_costs.set){ 
			num_particles = 100;
			col_particles = c_lime;
		}
		else if (rarity == item_rarity_costs.unique){
			num_particles = 100;
			col_particles = c_fuchsia;
		}
		part_type_color1(global.item_particles_pickup, col_particles);
		part_system_position(global.fx_system_2, x + (sprite_width / 2), y + (sprite_height / 2));
		part_emitter_burst(global.fx_system_2, global.fx_emitter_2, global.item_particles_pickup, num_particles);
		instance_destroy();
	}
	else
	{
		//show_debug_message("No empty slot found");
		obj_player.isInteracting = false;
		obj_player.interactingWithID = noone;
		isInteracting = false;
	}
	
}
