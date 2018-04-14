//======== 'ESC' ========== EXIT GAME
if (keyboard_check(vk_escape)){
	global.in_game = false;
	game_end();
}

if (keyboard_check_pressed(ord("F")))
{
	instance_create_layer(420, 140, "Layer_Objects", obj_enemy_spawner);
	instance_create_layer(1400, 140, "Layer_Objects", obj_enemy_spawner);

}

//======== 'I' ========= OPEN INVENTORY
if (keyboard_check_pressed(global.settings[? "inventory_shortcut"])){
	if (global.inventory_open) 
	{
		global.inventory_open = false;
		get_expanded_slot = false;
		item_expanded = false;
		equipment_expanded = false;
		currently_selected_item = noone;
		currently_selected_slot = noone;
	}
	else 
	{
		if (global.character_sheet_open)
		{
			global.character_sheet_open = false;
		}
		global.inventory_open = true;
	}
}

if (keyboard_check_pressed(global.settings[? "character_sheet_shortcut"])){
	if (global.character_sheet_open)
	{
		global.character_sheet_open = false;
		global.anything_open = false;
	}
	else
	{
		if (global.inventory_open) 
		{
			global.inventory_open = false;
			get_expanded_slot = false;
			item_expanded = false;
			equipment_expanded = false;
			currently_selected_item = noone;
			currently_selected_slot = noone;
		}
		global.character_sheet_open = true;
	}
}

//========= 'LEFT_BUTTON' ====== OPEN ITEM EXPANSION IN INVENTORY SCREEN
if (mouse_check_button_pressed(mb_left) == true && global.inventory_open)
{
	get_expanded_slot = true;
}

