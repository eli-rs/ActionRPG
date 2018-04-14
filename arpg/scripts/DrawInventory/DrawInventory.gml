// We pass in the current screen coordinates of the mouse so that we can draw the hover slots and items appropriately
var mx = argument0;
var my = argument1;

var inv_sprite = spr_inv_9slice_1;
var slot_sprite = spr_inv_slot_small;
var slice_size = sprite_get_width(inv_sprite) / 3;
var slot_size = sprite_get_width(slot_sprite);

var top_left_slot = global.inventory[| 0]; // the first slot in the inventory
var bottom_right_slot = global.inventory[| ds_list_size(global.inventory) - 1]; // the last slot in the inventory

#region Draw the Inventory Panel and Inventory Header Text
NineSliceStretched(inv_sprite, global.inventory_left, global.inventory_top, global.inventory_right, global.inventory_bottom, 1);
var max_title_width = (global.inventory_right - global.inventory_left) - (2 * slice_size);
var title_scale = (slot_size * 0.8) / string_height("Inventory");
var title_x = global.inventory_left + slice_size + (max_title_width / 2);
draw_text_transformed(title_x, global.inventory_top + (2 * slice_size), "Inventory", title_scale, title_scale, 0);
#endregion

#region Draw Item Info Panel
if (item_expanded)
{
	var panel_x = global.inventory_right + 1;
	var panel_x2 = global.inventory_right + 1 + (global.inventory_right - global.inventory_left);
	var panel_y = global.inventory_top + ((global.inventory_bottom - global.inventory_top) / 2) + 7;
	var panel_y2 = global.inventory_bottom + 6;
	
	NineSliceStretched(inv_sprite, panel_x, panel_y, panel_x2, panel_y2, 1);
	
	draw_sprite(inv_sprite, 3, panel_x2 - 6, panel_y - 1);
	
	// get the coordinates for pressing the 'close' button in top right corner of panel
	var close_x = panel_x2 - 6;
	var close_x2 = close_x + 7;
	var close_y = panel_y - 1;
	var close_y2 = close_y + 7;
	
	// check if player is trying to close the panel, if so: close the panel
	if (mouse_check_button_pressed(mb_left) &&
		mx >= close_x && mx <= close_x2 &&
		my >= close_y && my <= close_y2)
		item_expanded = false;
	
	var panel_width = (panel_x2 - panel_x) - (2 * slice_size);
	var name_start =	panel_x + (panel_x2 - panel_x ) / 2;
	
	var item_name = currently_selected_item[? "name"];
	var item_rarity = currently_selected_item[? "rarity"];
	var item_level = currently_selected_item[? "level"];
	var item_value = currently_selected_item[? "value"];
	var item_type = currently_selected_item[? "item_type"];
	var item_base_type = currently_selected_item[? "base_type"];
	var item_base = currently_selected_item[? "base_values"];
	
	
	var name_width = string_width(item_name);
	var xscale = min(0.25, panel_width / name_width);
	
	if (name_width * 0.25 > panel_width)
	{
		xscale = 0.2;
		var split_at_next_space = false;
		var current_string = "";
		var last_space = 0;
		for (var i = 1; i < string_length(item_name); i++)
		{
			var char = string_char_at(item_name, i);
			if (char == " ") last_space = i;
			
			if (string_width(current_string) * 0.25 > panel_width) break;
			else current_string += string_char_at(item_name, i);
		}
		item_name = string_insert("\n", item_name, last_space);
		
	}
	// Draw the Item Name at the top of the info panel
	draw_text_transformed(name_start, panel_y + slice_size, item_name, xscale, xscale, 0);
	var name_height = string_height(item_name) * xscale;
	
	var item_stats = currently_selected_item[? "stats"];
	var stats_start_y = panel_y + slice_size + name_height;
	var stat_scale = 0.1;
	var line_color;
	var rarity_str = "";
	
	if (item_rarity == item_rarity_costs.common) { line_color = c_gray; rarity_str = "Common"; }
	else if (item_rarity == item_rarity_costs.uncommon) { line_color = c_yellow; rarity_str = "Uncommon"; }
	else if (item_rarity == item_rarity_costs.rare) { line_color = c_teal; rarity_str = "Rare"; }
	else if (item_rarity == item_rarity_costs.unique) { line_color = c_purple; rarity_str = "Unique"; }
	else if (item_rarity == item_rarity_costs.set) { line_color = c_green; rarity_str = "Set"; }
	// draw line using rarity color, separating item name from item stats
	draw_line_width_color(panel_x + (2 * slice_size), stats_start_y, panel_x2 - (2 * slice_size), stats_start_y, 1, line_color, line_color);
	var rarity_scale = 0.07;
	var rarity_height = string_height(rarity_str) * rarity_scale;
	
	draw_set_font(fnt_start);
	// draw rarity text
	draw_text_transformed(panel_x2 - 24, stats_start_y + (rarity_height / 2) + 1, string_upper(rarity_str), rarity_scale, rarity_scale, 0);
	// draw item type text
	draw_text_transformed(panel_x + 24, stats_start_y + (rarity_height / 2) + 1, string_upper(item_type), rarity_scale, rarity_scale, 0);
	
	var offset_stats = 0;

	var offset_base = 6;

	if (item_base_type == "weapon")
	{
		var wep_text = "Base Damage: " + string(item_base[| 0]) + " to " + string(item_base[| 1]);
		draw_text_transformed(name_start, stats_start_y + offset_base, 
			string_upper(wep_text), stat_scale, stat_scale, 0);
				
		offset_stats = (string_height(wep_text) * stat_scale) + offset_base;
		draw_line(panel_x + (3 * slice_size), stats_start_y + offset_stats + 2, panel_x2 - (3 * slice_size), stats_start_y + offset_stats + 2);

	}
	else if (item_base_type == "offhand")
	{
		if (item_type == "Shield")
		{
			var chance_text = "Chance to Block: " + string(item_base[| 0]);
			var recovery_text = "Shield Recovery Rate: " + string(item_base[| 1]);
			// var shield_deflection = ...
			draw_text_transformed(name_start, stats_start_y + offset_base, 
				string_upper(chance_text), stat_scale, stat_scale, 0);
			draw_text_transformed(name_start, stats_start_y + offset_base + 2 + (string_height(chance_text) * stat_scale), 
				string_upper(recovery_text), stat_scale, stat_scale, 0);
			
			offset_stats = (string_height(chance_text) * stat_scale * 2) + offset_base + 2;
			draw_line(panel_x + (3 * slice_size), stats_start_y + offset_stats + 2, panel_x2 - (3 * slice_size), stats_start_y + offset_stats + 2);
		}
		else if (item_type == "Ammo")
		{
			var speed_text = "Projectile Speed: " + string(item_base[| 0]);
			var spread_text = "Projectile Spread: " + string(item_base[| 1]);
			
			draw_text_transformed(name_start, stats_start_y + offset_base, 
				string_upper(speed_text), stat_scale, stat_scale, 0);
			draw_text_transformed(name_start, stats_start_y + offset_base + 2 + (string_height(speed_text) * stat_scale), 
				string_upper(spread_text), stat_scale, stat_scale, 0);
			
			offset_stats = (string_height(speed_text) * stat_scale * 2) + offset_base + 2;
			draw_line(panel_x + (3 * slice_size), stats_start_y + offset_stats + 2, panel_x2 - (3 * slice_size), stats_start_y + offset_stats + 2);
		}
		else if (item_type == "Tome")
		{
			var speed_text = "Spell Speed: " + string(item_base[| 0]);
			var spread_text = "Spell Spread: " + string(item_base[| 1]);
			
			draw_text_transformed(name_start, stats_start_y + offset_base, 
				string_upper(speed_text), stat_scale, stat_scale, 0);
			draw_text_transformed(name_start, stats_start_y + offset_base + 2 + (string_height(speed_text) * stat_scale), 
				string_upper(spread_text), stat_scale, stat_scale, 0);
			
			offset_stats = (string_height(speed_text) * stat_scale * 2) + offset_base + 2;
			draw_line(panel_x + (3 * slice_size), stats_start_y + offset_stats + 2, panel_x2 - (3 * slice_size), stats_start_y + offset_stats + 2);
		}
	}
	else if (item_base_type == "armor")
	{
		var deflect_text = "Armor Deflection: " + string(item_base[| 0]);
		var absorb_text = "Armor Absorption: " + string(item_base[| 1]);
		draw_text_transformed(name_start, stats_start_y + offset_base, 
			string_upper(deflect_text), stat_scale, stat_scale, 0);
		draw_text_transformed(name_start, stats_start_y + offset_base + 2 + (string_height(deflect_text) * stat_scale), 
			string_upper(absorb_text), stat_scale, stat_scale, 0);
				
		offset_stats = (string_height(deflect_text) * stat_scale * 2) + offset_base + 2;
		draw_line(panel_x + (3 * slice_size), stats_start_y + offset_stats + 2, panel_x2 - (3 * slice_size), stats_start_y + offset_stats + 2);
	}
	
	// loop through each item stat and draw it as text using StatToString
	for (var i = 0; i < ds_list_size(item_stats); i++)
	{
		stat_scale = 0.1;
		var stat_map = item_stats[| i];
		var stat_string = StatToString(stat_map);
		var stat_width = string_width(string_upper(stat_string));
		var stat_height = string_height(string_upper(stat_string));
		
		if (stat_width * stat_scale >= panel_x2 - panel_x - (2 * slice_size))
			stat_scale = (panel_x2 - panel_x - (2 * slice_size)) / stat_width;
		draw_text_transformed(name_start, offset_stats + stats_start_y + slice_size + (i * string_height(stat_string) * 0.1) + (i * 2), 
			string_upper(stat_string), stat_scale, stat_scale, 0);
		
	}
	
	draw_set_font(fnt_rogue);
}
#endregion

#region Draw Equipment Panel
if (equipment_expanded)
{
	NineSliceStretched(inv_sprite, global.equipment_left, global.equipment_top, global.equipment_right, global.equipment_bottom, 1);
	var header_start = global.equipment_left + (global.equipment_right - global.equipment_left ) / 2;
	draw_text_transformed(header_start, global.equipment_top + (2 * slice_size), "Equipment", 0.3, 0.3, 0);
	
	draw_sprite(inv_sprite, 3, global.equipment_right - 6, global.equipment_top - 1);
	
	// get the coordinates for pressing the 'close' button in top right corner of panel
	var close_x = global.equipment_right - 6;
	var close_x2 = close_x + 7;
	var close_y = global.equipment_top - 1;
	var close_y2 = close_y + 7;
	
	// check if player is trying to close the panel, if so: close the panel
	if (mouse_check_button_pressed(mb_left) &&
		mx >= close_x && mx <= close_x2 &&
		my >= close_y && my <= close_y2)
		equipment_expanded = false;
	
	for (var i = 0; i < ds_list_size(global.equipment); i++)
	{
		var equip_slot = global.equipment[| i];
		draw_sprite(slot_sprite, 0, equip_slot[? "x"], equip_slot[? "y"]);
		var slot_id = equip_slot[? "item_id"];
		
		if (slot_id != -1)
		{
			var item_map = global.items[| slot_id];
			draw_sprite(item_map[? "sprite_index"], item_map[? "image_index"], equip_slot[? "x"], equip_slot[? "y"]);
		}
	}
	
	//draw_text_transformed(mx, my, string(mx) + ", " + string(my), 0.5, 0.5, 0);

}
#endregion

#region Draw Items Contained in the Inventory
for (var i = 0; i < ds_list_size(global.inventory); i++)
{
	var slot = global.inventory[| i];
	draw_sprite(slot_sprite, 0, slot[? "x"], slot[? "y"]);
	var item_id = slot[? "item_id"];
	if (item_id != -1)
	{
		var item_map = global.items[| item_id];
		var item_rarity = item_map[? "rarity"];
		var slot_rarity_frame = 2;
		if (item_rarity == item_rarity_costs.uncommon)
			slot_rarity_frame = 3;
		else if (item_rarity == item_rarity_costs.rare)
			slot_rarity_frame = 4;
		else if (item_rarity == item_rarity_costs.set)
			slot_rarity_frame = 5;
		else if (item_rarity == item_rarity_costs.unique)
			slot_rarity_frame = 6;
		
		draw_sprite(slot_sprite, slot_rarity_frame, slot[? "x"], slot[? "y"]);	
		draw_sprite(item_map[? "sprite_index"], item_map[? "image_index"], slot[? "x"], slot[? "y"]);
	}
}
#endregion

#region Drag and Drop Item, Enable Equipment and Item Info Panels on Click
if (dragging_item)
{
	draw_sprite(item_dragged[? "sprite_index"], item_dragged[? "image_index"], mx - offset_x, my - offset_y);
	if (mouse_check_button_released(mb_left))
	{
		var item_unequipped = noone;
		var item_equipped = noone;
		var return_to_original = false;
		
		#region If We Simply Click An Item, Then Open Info Panels & Do Nothing
		if (mx >= original_slot[? "x"] && mx <= original_slot[? "x"] + slot_size &&
			my >= original_slot[? "y"] && my <= original_slot[? "y"] + slot_size)
		{
			original_slot[? "item_id"] = item_dragged[? "id"];
			item_expanded = true;
			equipment_expanded = true;
			currently_selected_slot = original_slot;
			currently_selected_item = item_dragged;
			dragging_swapable = false;
		}
		#endregion
		else
		{	
			#region If Item Dropped Within Inventory, Move Item to that Slot
			if (mx >= top_left_slot[? "x"] && mx <= bottom_right_slot[? "x"] + global.inventory_slot_size &&
				my >= top_left_slot[? "y"] && my <= bottom_right_slot[? "y"] + global.inventory_slot_size)
			{
				show_debug_message("item was dropped within bounds of inventory panel")
					
				var col_num = floor( (mx - top_left_slot[? "x"]) / global.inventory_slot_size );
				var row_num = floor( (my - top_left_slot[? "y"]) / global.inventory_slot_size );
				
				var slot_index = col_num + (row_num * global.inventory_columns);
				var slot_map = global.inventory[| slot_index];
				var new_id = slot_map[? "item_id"];
				var slot_occupied = (new_id != -1);
				// if there's an item there, set old slot to have new item
				if (slot_occupied)
				{
					if (dragging_from_equipment) 
					{
						var next_empty = GetNextInventorySlot();
						if (next_empty != noone)
						{
							var empty_slot = global.inventory[| next_empty];
							empty_slot[? "item_id"] = slot_map[? "item_id"];
							slot_map[? "item_id"] = item_dragged[? "id"];
							item_unequipped = item_dragged;
						}
						else
						{
							original_slot[? "item_id"] = item_dragged[? "id"];
						}
					}					
					// IF WE ARE NOT DRAGGING FROM EQUIPMENT (if we are dragging from inventory to inventory)
					else
					{
						original_slot[? "item_id"] = slot_map[? "item_id"];
						slot_map[? "item_id"] = item_dragged[? "id"];
					}
				}
				// if we dragged item into an empty slot, then we just move it there
				else 
				{
					slot_map[? "item_id"] = item_dragged[? "id"];
					if (dragging_from_equipment)
						item_unequipped = item_dragged;
				}
					
				if (dragging_from_equipment)
				{
					item_expanded = true;
					equipment_expanded = true;
					currently_selected_slot = slot_map;
					currently_selected_item = item_dragged;
				}
				else
				{
				// this means we havent actually moved the item, we clicked and remaining in the same slot
					if (slot_map[? "id"] == original_slot[? "id"])
					{
						item_expanded = true;
						equipment_expanded = true;
						currently_selected_slot = original_slot;
						currently_selected_item = item_dragged;
					}
				}
				
			}
			
			#endregion
		
			#region Else If Item Dropped Within Equipment, Equip Item
			else if (mx >= global.equipment_left && mx <= global.equipment_right && my >= global.equipment_top && my <= global.equipment_bottom)
			{
				show_debug_message("item was dropped within bounds of equipment panel")
				var dragged_type = item_dragged[? "item_type"];
				var dragged_base = item_dragged[? "base_type"];
			
				#region Item Being Dragged From Equipment Panel To Equipment Panel
				if (dragging_from_equipment)
				{
					var slot_selected = original_slot;
					item_equipped = noone;
					item_unequipped = noone;
					
					#region Dragging Ring From Equipment Panel TO Equipment Panel
					if (dragged_type == "Ring")
					{
						var left_slot = global.equipment[| equipment.ring_left];
						var right_slot = global.equipment[| equipment.ring_right];	
					
						if (mx >= left_slot[? "x"] && mx <= left_slot[? "x"] + slot_size &&
								my >= left_slot[? "y"] && my <= left_slot[? "y"] + slot_size)
						{
							original_slot[? "item_id"] = left_slot[? "item_id"];
							left_slot[? "item_id"] = item_dragged[? "id"];
							slot_selected = left_slot;
						}
						else if (mx >= right_slot[? "x"] && mx <= right_slot[? "x"] + slot_size &&
							my >= right_slot[? "y"] && my <= right_slot[? "y"] + slot_size)
						{
							original_slot[? "item_id"] = right_slot[? "item_id"];
							right_slot[? "item_id"] = item_dragged[? "id"];
							slot_selected = right_slot;
						}
						else
						{
							original_slot[? "item_id"] = item_dragged[? "id"];
						}
					}
					#endregion
					
					#region Dragging Weapon From Equipment Panel TO Either Offhand Slot or Original Slot
					else if (item_dragged[? "base_type"] == "weapon")
					{
						offhand_slot = global.equipment[| equipment.offhand];
						// if we drag a weapon from within equipment panel to the offhand slot
						if (mx >= offhand_slot[? "x"] && mx <= offhand_slot[? "x"] + slot_size &&
							my >= offhand_slot[? "y"] && my <= offhand_slot[? "y"] + slot_size)
						{
							// if we are dragging wep into an empty slot (offhand is empty)
							if (offhand_slot[? "item_id"] == -1)
							{
								offhand_slot[? "item_id"] = item_dragged[? "id"];
								item_equipped = item_dragged;
							}
							else
							{
								// else if we are dragging wep into an occupied offhand slot
								var offhand_item = global.items[| offhand_slot[? "item_id"]];
								if (offhand_item[? "base_type"] == "offhand")
								{
									var empty_slot_index = GetNextInventorySlot();
									if (empty_slot_index != noone)
									{
										var empty_slot = global.inventory[| empty_slot_index];
							
										original_slot[? "item_id"] = -1;
										var current_offhand = offhand_slot[? "item_id"];
										empty_slot[? "item_id"] = current_offhand;
										offhand_slot[? "item_id"] = item_dragged[? "id"];
										slot_selected = offhand_slot;
							
										item_unequipped = global.items[| current_offhand];
									}
									else
									{
										original_slot[? "item_id"] = item_dragged[? "id"];
										slot_selected = original_slot;
									}
								}
								else if (offhand_item[? "base_type"] == "weapon")
								{
									original_slot[? "item_id"] = offhand_slot[? "item_id"];
									offhand_slot[? "item_id"] = item_dragged[? "id"];
									slot_selected = offhand_slot;
								}
							}
						}
						else
						{
							// if weapon was dragged from within equipment panel and NOT into the offhand slot
							var primary_slot = global.equipment[| equipment.weapon];
							if (primary_slot[? "item_id"] == -1)
							{
								// if primary slot is empty then move wep to primary slot
								primary_slot[? "item_id"] = item_dragged[? "id"];
							}
							else
							{
								if (mx >= primary_slot[? "x"] && mx <= primary_slot[? "x"] + slot_size &&
									my >= primary_slot[? "y"] && my <= primary_slot[? "y"] + slot_size)
								{
									offhand_slot[? "item_id"] = primary_slot[? "item_id"];
									primary_slot[? "item_id"] = item_dragged[? "id"];
								}
								else
									original_slot[? "item_id"] = item_dragged[? "id"];
							}
						}
						
					}
					#endregion
					
					#region Dragging Any Other Item Type Within Equipment Panel Returns Item to Original Slot
					else				
					{
						original_slot[? "item_id"] = item_dragged[? "id"];
						slot_selected = original_slot;
					}
					#endregion
				
					item_expanded = true;
					equipment_expanded = true;
					currently_selected_slot = slot_selected;
					currently_selected_item = item_dragged;
				}
				#endregion
				
				else
				{
					// IF WE ARE DRAGGING FROM INVENTORY PANEL INTO EQUIPMENT PANEL:
					// AND OUR ITEM IS NOT A RING
					if (dragged_type != "Ring" && dragged_base != "weapon" && dragged_base != "offhand") 
					{
						for (var i = 0; i < ds_list_size(global.equipment); i++)
						{
							var equip_map = global.equipment[| i];
							// if we are checking a slot of our item's type
							if (equip_map[? "item_type"] == dragged_type)
							{
							
								var currently_equipped_id = equip_map[? "item_id"];
								// if appropriate slot is OCCUPIED, put new item in it
								if (currently_equipped_id != -1)
								{
									// move item in equipment slot into the original slot
									original_slot[? "item_id"] = currently_equipped_id;
									item_unequipped = global.items[| currently_equipped_id];
								}

								equip_map[? "item_id"] = item_dragged[? "id"];
								item_equipped = item_dragged;
						
								// unlike dragging in the inventory, whenever we drag/click any item in the equipment panel
								// we will always automatically display its item info in the info panel
								item_expanded = true;
								equipment_expanded = true;
								currently_selected_slot = equip_map;
								currently_selected_item = item_dragged;

								break;
							}
						}
					}
					else if (dragged_base == "offhand")
					{
						// ONCE THIS IS ALL WORKING, EXTEND THIS SECTION TO MAKE SURE THAT A TOME CAN ONLY BE EQUIPPED WITH A WAND
						// AND THAT AN ARROW CAN ONLY BE EQUIPPED WITH A BOW, ETC
						var offhand_slot = global.equipment[| equipment.offhand];
						if (offhand_slot[? "item_id"] == -1)
						{
							offhand_slot[? "item_id"] = item_dragged[? "id"];
							item_equipped = item_dragged;
						}
						else 
						{
							var currently_equipped = offhand_slot[? "item_id"];
							original_slot[? "item_id"] = currently_equipped;
							offhand_slot[? "item_id"] = item_dragged[? "id"];
							item_unequipped = global.items[| currently_equipped];
							item_equipped = item_dragged;
						}
					
						item_expanded = true;
						equipment_expanded = true;
						currently_selected_slot = offhand_slot;
						currently_selected_item = item_dragged;
					}
					else if (dragged_base == "weapon")
					{
					
						var offhand_slot = global.equipment[| equipment.offhand];
						var slot_used;
						// if weapon was dropped directly into offhand slot
						if (mx >= offhand_slot[? "x"] && mx <= offhand_slot[? "x"] + slot_size &&
							my >= offhand_slot[? "y"] && my <= offhand_slot[? "y"] + slot_size)
						{
							slot_used = offhand_slot;
							// and offhand slot is empty, then move dragged item to offhand slot
							if (offhand_slot[? "item_id"] == -1)
							{
								offhand_slot[? "item_id"] = item_dragged[? "id"];
								item_equipped = item_dragged;
							}
							else 
							{
								// if offhand slot was occupied
								var offhand_item = global.items[| offhand_slot[? "item_id"]];
								// and it was occupied with an offhand, move dragged item to offhand, and offhand item to original slot
								if (offhand_item[? "base_type"] == "offhand")
								{
									original_slot[? "item_id"] = offhand_slot[? "item_id"];
									item_unequipped = offhand_item;
									offhand_slot[? "item_id"] = item_dragged[? "id"];
									item_equipped = item_dragged;
								}
								// else if offhand item was a weapon
								else if (offhand_item[? "base_type"] = "weapon")
								{
									var primary_slot = global.equipment[| equipment.weapon];
									// and primary weapon slot was empty, then move dragged item to offhand and offhand item to primary slot
									if (primary_slot[? "item_id"] == -1)
									{
										primary_slot[? "item_id"] = offhand_slot[? "item_id"];
										offhand_slot[? "item_id"] = item_dragged[? "id"];
										item_equipped = item_dragged;
									}
									// if primary slot was occupied, then replace offhand with dragged item, and move offhand into inventory
									else
									{
										original_slot[? "item_id"] = offhand_slot[? "item_id"];
										item_unequipped = offhand_item;
										offhand_slot[? "item_id"] = item_dragged[? "id"];
										item_equipped = item_dragged;
									}
								}
							}
							
						}
						// if weapon was dragged into equipment panel but NOT into the offhand slot
					
						else 
						{
							var primary_slot = global.equipment[| equipment.weapon];
							slot_used = primary_slot;
							// if primary weapon slot is empty, then move weapon into primary slot
							if (primary_slot[? "item_id"] == -1)
							{
								primary_slot[? "item_id"] = item_dragged[? "id"];
								item_equipped = item_dragged;
							}
							// if primary slot was already occupied
							else
							{
								original_slot[? "item_id"] = primary_slot[? "item_id"];
								item_unequipped = global.items[| primary_slot[? "item_id"]];
								primary_slot[? "item_id"] = item_dragged[? "id"];
								item_equipped = item_dragged;
							}
						}
						if (slot_used == noone) show_debug_message("!!!!!!!!!! SLOT_USED WAS NEVER SET PROPERLY !!!!!!!!");
						item_expanded = true;
						equipment_expanded = true;
						currently_selected_slot = slot_used;
						currently_selected_item = item_dragged;
					
					}
					else if (dragged_type == "Ring")
					{
				
						var left_slot = global.equipment[| equipment.ring_left];
						var right_slot = global.equipment[| equipment.ring_right];
				
						var left_occupied = left_slot[? "item_id"] != -1;
						var right_occupied = right_slot[? "item_id"] != - 1;
						if (dragging_swapable)
						{ left_occupied = true; right_occupied = true}
				
						var slot_selected;
				
						if (left_occupied == false)
						{
							left_slot[? "item_id"] = item_dragged[? "id"];
							item_equipped = item_dragged;
							slot_selected = left_slot;
						}
						else if (right_occupied == false)
						{
							right_slot[? "item_id"] = item_dragged[? "id"];
							item_equipped = item_dragged;
							slot_selected = right_slot;
						}
					
						else if (left_occupied && right_occupied)
						{
							// IF BOTH SLOTS OCCUPIED: IF DRAGGED TO LEFT, PUT IN LEFT; IF RIGHT, PUT IN RIGHT; IF NEITHER, PUT IN LEFT
							if (mx >= left_slot[? "x"] && mx <= left_slot[? "x"] + slot_size &&
								my >= left_slot[? "y"] && my <= left_slot[? "y"] + slot_size)
							{
								original_slot[? "item_id"] = left_slot[? "item_id"];
								left_slot[? "item_id"] = item_dragged[? "id"];
								slot_selected = left_slot;
							}
							else if (mx >= right_slot[? "x"] && mx <= right_slot[? "x"] + slot_size &&
								my >= right_slot[? "y"] && my <= right_slot[? "y"] + slot_size)
							{
								original_slot[? "item_id"] = right_slot[? "item_id"];
								right_slot[? "item_id"] = item_dragged[? "id"];
								slot_selected = right_slot;
							}
							else
							{
								original_slot[? "item_id"] = left_slot[? "item_id"];
								left_slot[? "item_id"] = item_dragged[? "id"];
								slot_selected = left_slot;
							}
							item_unequipped = global.items[| original_slot[? "item_id"]];
							item_equipped = item_dragged;
						}		
				
						item_expanded = true;
						equipment_expanded = true;
						currently_selected_slot = slot_selected;
						currently_selected_item = item_dragged;
						dragging_swapable = false;
					}
				}
			}
			#endregion
			
			#region If Item Dropped Outside Bounds of Both Inventory AND Equipment Panels (return to orig slot // drop on ground)
			else 
			{
				show_debug_message("THIS IS WHERE WE WOULD DROP AN ITEM ON THE GROUND")
				original_slot[? "item_id"] = item_dragged[? "id"];
			}
			#endregion
		}
		
		dragging_item = false;
		dragging_from_equipment = false;
		//dragging_swapable = false;
		if (item_equipped != noone)
		{
			ParseEquipment(true, item_equipped);
			
		}
		if (item_unequipped != noone)
		{
			ParseEquipment(false, item_unequipped);
		}
		
	}
}
#endregion

#region Draw Item Name on Mouse Hover, Start Item Drag on Mouse Click
// If the mouse cursor is currently within the interactable inventory rectangle
if (dragging_item == false)
{
	if (mx >= top_left_slot[? "x"] && mx <= bottom_right_slot[? "x"] + global.inventory_slot_size)
	{
		if (my >= top_left_slot[? "y"] && my <= bottom_right_slot[? "y"] + global.inventory_slot_size)
		{
			var col_num = floor( (mx - top_left_slot[? "x"]) / global.inventory_slot_size );
			var row_num = floor( (my - top_left_slot[? "y"]) / global.inventory_slot_size );
			//draw_text(mouse_screen_x, mouse_screen_y, "(" + string(col_num) + ", " + string(row_num) + ")");
		
			// row_num * num_of_columns gives us the # of slots per row									
			var slot_index = col_num + (row_num * global.inventory_columns);
			var slot_map = global.inventory[| slot_index];
			var item_id = slot_map[? "item_id"];
			if (item_id != -1)
			{
				var slot_x = slot_map[? "x"];
				var slot_y = slot_map[? "y"];
				var item_map = global.items[| item_id];
					var item_rarity = item_map[? "rarity"];
				var slot_rarity_frame = 7;
				if (item_rarity == item_rarity_costs.uncommon)
					slot_rarity_frame = 8;
				else if (item_rarity == item_rarity_costs.rare)
					slot_rarity_frame = 9;
				else if (item_rarity == item_rarity_costs.set)
					slot_rarity_frame = 10;
				else if (item_rarity == item_rarity_costs.unique)
					slot_rarity_frame = 11;
					
				draw_sprite(slot_sprite, slot_rarity_frame, slot_x, slot_y);
				
				// we need to redraw the item or else it will appear underneath the hover slot
				draw_sprite(item_map[? "sprite_index"], item_map[? "image_index"], slot_x, slot_y);
				var item_name = item_map[? "name"];

				var name_width = 0.2 * string_width(item_name);
				var name_height = 0.2 * string_height(item_name);

				var box_x = slot_x + global.inventory_slot_size - 3;
				var box_y = slot_y - 2;
				var box_x2 = box_x + name_width + 4;
				var box_y2 = slot_y + name_height + 2;

				NineSliceStretched(spr_inv_hoverbox, box_x, box_y, box_x2, box_y2, 0.7);
				
				draw_text_transformed(slot_x + global.inventory_slot_size + (name_width / 2), slot_y, item_name,0.2,0.2,0);
								
				if (mouse_check_button_pressed(mb_left))
				{
					 dragging_item = true;
					 item_dragged = item_map;
					 original_slot = slot_map;
					 original_slot[? "item_id"] = -1;
					 offset_x = mx - slot_x;
					 offset_y = my - slot_y;
				}

			}
		}
	}
	// if equipment panel is open, and mouse is in equipment panel, then check for hover,click,etc
	if (equipment_expanded && mx >= global.equipment_left && mx <= global.equipment_right &&
		my >= global.equipment_top && my <= global.equipment_bottom)
	{
	
		for (var i = 0; i < ds_list_size(global.equipment); i++)
		{
			var equip_map = global.equipment[| i];
			var equip_id = equip_map[? "item_id"];
			if (equip_id != -1)
			{
				var slotx = equip_map[? "x"];
				var sloty = equip_map[? "y"];

				if (mx >= slotx && mx <= slotx + slot_size)
				{
					if (my >= sloty && my <= sloty + slot_size)
					{
						var item_map = global.items[| equip_id];
						var equip_name = item_map[? "name"];
						
						var name_width = 0.2 * string_width(equip_name);
						var name_height = 0.2 * string_height(equip_name);

						var box_x = slotx + global.inventory_slot_size - 3;
						var box_y = sloty - 2;
						var box_x2 = box_x + name_width + 4;
						var box_y2 = sloty + name_height + 2;

						NineSliceStretched(spr_inv_hoverbox, box_x, box_y, box_x2, box_y2, 0.7);
				
						draw_text_transformed(slotx + global.inventory_slot_size + (name_width / 2), sloty, equip_name,0.2,0.2,0);
								
						if (mouse_check_button_pressed(mb_left))
						{
							dragging_from_equipment = true;
							dragging_item = true;
							item_dragged = item_map;
							original_slot = equip_map;
							original_slot[? "item_id"] = -1;
							offset_x = mx - slotx;
							offset_y = my - sloty;
							if (item_map[? "item_type"] == "Ring")
							dragging_swapable = true;
							
						}
						
						
					}
				}
			}
		}
	}
}
#endregion

#region Draw Player's Current Currency in Bottom Right Corner
var player_gold = obj_player.player_currency;
var currency_text_width = string_width("Gold: " + string(player_gold));
var currency_text_scale =  (((global.inventory_right - global.inventory_left) / 6) / currency_text_width);
draw_set_halign(fa_right);

var gold_index = 10;
if (player_gold > 50) gold_index = 9;
if (player_gold > 150) gold_index = 8;
var gold_width = sprite_get_width(spr_items_currencies);
// DRAW THE "GOLD: __" TEXT IN BOTTOM RIGHT OF INVENTORY
draw_text_transformed_color(global.inventory_right - (slice_size) - gold_width, global.inventory_bottom - (2 * slice_size), 
	"Gold: " + string(obj_player.player_currency), currency_text_scale, currency_text_scale, 0, c_yellow, c_yellow, c_yellow, c_yellow, 1);
// DRAW THE PILE-OF-GOLD SPRITE
draw_sprite_ext(spr_items_currencies, gold_index, 
	global.inventory_right - slice_size - gold_width, 
	global.inventory_bottom - (2.5 * slice_size), 
	0.75, 0.75, 0, c_white, 1);
	
draw_set_halign(fa_center);
#endregion


