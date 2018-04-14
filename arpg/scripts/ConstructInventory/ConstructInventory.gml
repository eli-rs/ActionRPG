
//#region Draw Inventory Border
var inv_sprite = spr_inv_9slice_1;
var slot_sprite = spr_inv_slot_small;

var slice_size = sprite_get_width(inv_sprite) / 3;
var inv_margin = 24;


var inv_x2 = (global.view_width / 2) - inv_margin;
var inv_y2 = global.view_height - inv_margin; 

//NineSliceStretched(inv_sprite, inv_margin, inv_margin, inv_x2, inv_y2);

var inv_width = abs(inv_x2 - inv_margin);
var inv_height = abs(inv_y2 - inv_margin);

global.inventory_left = inv_margin;
global.inventory_top = inv_margin;
global.inventory_right = inv_x2;
global.inventory_bottom = inv_y2;

var slot_size = sprite_get_width(slot_sprite);
global.inventory_slot_size = slot_size;
var slots_in_row = floor((inv_width - (2 * slice_size)) / slot_size);
var slots_in_col = floor((inv_height - (2* slice_size)) / slot_size);

global.inventory_columns = slots_in_row;
global.inventory_rows = slots_in_col;

// our starting slot position, dividing by 2 to center the slots in the inventory panel
var start_x = inv_margin + slice_size + ( ( (inv_width - (2 * slice_size)) % slot_size) / 2);
var start_y = inv_margin + slice_size + ( ( (inv_height - (2 * slice_size)) % slot_size) / 2);

global.inventory = ds_list_create();
for (var rownum = 1; rownum < slots_in_col; rownum++)
{
	for (var colnum = 0; colnum < slots_in_row; colnum++)
	{
		var slot_x = start_x + (colnum * slot_size);
		var slot_y = start_y + (rownum * slot_size);
		
		//draw_sprite(slot_sprite, 0, slot_x, slot_y);
		var slot_map = ds_map_create();
		slot_map[? "x"] = slot_x;
		slot_map[? "y"] = slot_y;
		slot_map[? "id"] = ds_list_size(global.inventory);
		slot_map[? "item_id"] = -1;
		
		ds_list_add(global.inventory, slot_map);
		
	}
}

global.equipment = ds_list_create();
global.equipment_left = global.inventory_right + 1;
global.equipment_top = global.inventory_top - 19; 
global.equipment_right = global.inventory_right + 1 + (global.inventory_right - global.inventory_left);
global.equipment_bottom = global.inventory_top + ((global.inventory_bottom - global.inventory_top) / 2) + 6;

// CREATE OUR EQUIPMENT SLOTS
// Helm, Amulet, Cloak, Chest Armor, Bracers, Gauntlets, Rings, Belt, Greaves, Boots

/*			helm
		amulet cloak
wep 1	chest armor		 wep 2
	bracers		gauntlets
	ring	belt		ring
			greaves
			boots
*/
var panel_center = global.equipment_left + ((global.equipment_right - global.equipment_left) / 2);
var needed_width = 5 * slot_size;
var panel_center_vert = global.equipment_top + ((global.equipment_bottom - global.equipment_top) / 2);
var needed_height = 6 * slot_size;
var first_x = panel_center - (needed_width / 2);
var first_y = panel_center_vert - (needed_height / 2);

enum equipment 
{
	helm,
	amulet,
	cloak,
	chest,
	weapon,
	bracers,
	belt,
	gloves,
	offhand,
	ring_left,
	greaves,
	ring_right,
	boots
}

var helm = ds_map_create();
helm[? "id"] = ds_list_size(global.equipment);
helm[? "x"] = first_x + (2 * slot_size);
helm[? "y"] = first_y + slot_size;
helm[? "item_id"] = -1;
helm[? "name"] = "Helm";
helm[? "item_type"] = "Helm";
global.equipment[| equipment.helm] = helm;

var amulet = ds_map_create();
amulet[? "id"] = ds_list_size(global.equipment);
amulet[? "x"] = first_x + slot_size;
amulet[? "y"] = first_y + slot_size;
amulet[? "item_id"] = -1;
amulet[? "name"] = "Amulet";
amulet[? "item_type"] = "Amulet";
global.equipment[| equipment.amulet] = amulet;

var cloak = ds_map_create();
cloak[? "id"] = ds_list_size(global.equipment);
cloak[? "x"] = first_x + (3 * slot_size);
cloak[? "y"] = first_y + slot_size;
cloak[? "item_id"] = -1;
cloak[? "name"] = "Cloak";
cloak[? "item_type"] = "Cloak";
global.equipment[| equipment.cloak] = cloak;

var chest = ds_map_create();
chest[? "id"] = ds_list_size(global.equipment);
chest[? "x"] = first_x + (2 * slot_size);
chest[? "y"] = first_y + (2 * slot_size);
chest[? "item_id"] = -1;
chest[? "name"] = "Chest Armor";
chest[? "item_type"] = "Chest Armor";
global.equipment[| equipment.chest] = chest;

var wep_1 = ds_map_create();
wep_1[? "id"] = ds_list_size(global.equipment);
wep_1[? "x"] = first_x;
wep_1[? "y"] = first_y + (2 * slot_size);
wep_1[? "item_id"] = -1;
wep_1[? "name"] = "Weapon Primary";
wep_1[? "item_type"] = "Weapon";
global.equipment[| equipment.weapon] = wep_1;

var bracers = ds_map_create();
bracers[? "id"] = ds_list_size(global.equipment);
bracers[? "x"] = first_x + (slot_size);
bracers[? "y"] = first_y + (2 * slot_size);
bracers[? "item_id"] = -1;
bracers[? "name"] = "Bracers";
bracers[? "item_type"] = "Bracers";
global.equipment[| equipment.bracers] = bracers;

var belt = ds_map_create();
belt[? "id"] = ds_list_size(global.equipment);
belt[? "x"] = first_x + (2 * slot_size);
belt[? "y"] = first_y + (3 * slot_size);
belt[? "item_id"] = -1;
belt[? "name"] = "Belt";
belt[? "item_type"] = "Belt";
global.equipment[| equipment.belt] = belt;

var gloves = ds_map_create();
gloves[? "id"] = ds_list_size(global.equipment);
gloves[? "x"] = first_x + (3 * slot_size);
gloves[? "y"] = first_y + (2 * slot_size);
gloves[? "item_id"] = -1;
gloves[? "name"] = "Gloves";
gloves[? "item_type"] = "Gloves";
global.equipment[| equipment.gloves] = gloves;

var wep_2 = ds_map_create();
wep_2[? "id"] = ds_list_size(global.equipment);
wep_2[? "x"] = first_x + (4 * slot_size);
wep_2[? "y"] = first_y + (2 * slot_size);
wep_2[? "item_id"] = -1;
wep_2[? "name"] = "Weapon Offhand";
wep_2[? "item_type"] = "Offhand";
global.equipment[| equipment.offhand] = wep_2;

var ring_1 = ds_map_create();
ring_1[? "id"] = ds_list_size(global.equipment);
ring_1[? "x"] = first_x + (slot_size);
ring_1[? "y"] = first_y + (3 * slot_size);
ring_1[? "item_id"] = -1;
ring_1[? "name"] = "Ring Left";
ring_1[? "item_type"] = "Ring";
global.equipment[| equipment.ring_left] = ring_1;

var greaves = ds_map_create();
greaves[? "id"] = ds_list_size(global.equipment);
greaves[? "x"] = first_x + (2 * slot_size);
greaves[? "y"] = first_y + (4 * slot_size);
greaves[? "item_id"] = -1;
greaves[? "name"] = "Greaves";
greaves[? "item_type"] = "Greaves";
global.equipment[| equipment.greaves] = greaves;

var ring_2 = ds_map_create();
ring_2[? "id"] = ds_list_size(global.equipment);
ring_2[? "x"] = first_x + (3 * slot_size);
ring_2[? "y"] = first_y + (3 * slot_size);
ring_2[? "item_id"] = -1;
ring_2[? "name"] = "Ring Right";
ring_2[? "item_type"] = "Ring";
global.equipment[| equipment.ring_right] = ring_2;

var boots = ds_map_create();
boots[? "id"] = ds_list_size(global.equipment);
boots[? "x"] = first_x + (2 * slot_size);
boots[? "y"] = first_y + (5 * slot_size);
boots[? "item_id"] = -1;
boots[? "name"] = "Boots";
boots[? "item_type"] = "Boots";
global.equipment[| equipment.boots] = boots;


global.items = ds_list_create();
global.loot_table = ds_map_create();

CreateItemDatabase(); 
/*
repeat(4) 
{
	var slot = global.equipment[| irandom_range(0, 12)];
	var item = global.items[| irandom_range(0, 30)];
	slot[? "item_id"] = item[? "id"];
}
*/
//AddItemToDatabase();
/*

var mx = argument0;
var my = argument1;

var inv_sprite = spr_inventory_border;

var border_size = sprite_get_width(inv_sprite);
var num_rows = 6;
var num_cols = 5;



draw_sprite(inv_sprite, 4, global.inventory_x - border_size, 
	global.inventory_y - border_size);
draw_sprite(inv_sprite, 5, global.inventory_x - border_size + ((num_cols + 1) * border_size), 
	global.inventory_y - border_size);
draw_sprite(inv_sprite, 6, global.inventory_x - border_size, 
	global.inventory_y - border_size + ((num_rows + 1) * border_size));
draw_sprite(inv_sprite, 7, global.inventory_x - border_size + ((num_cols + 1) * border_size), 
	global.inventory_y - border_size + ((num_rows + 1) * border_size));

//draw the horizontal border tiles
for (var i = 1; i < num_cols + 1; i++)
{
	draw_sprite(inv_sprite, 2, 
		(i * border_size) + global.inventory_x - border_size, 
		global.inventory_y - border_size);
	draw_sprite(inv_sprite, 3, 
		(i * border_size) + global.inventory_x - border_size, 
		((num_rows + 1) * border_size) + global.inventory_y - border_size);
}

// draw the vertical border tiles
for (var i = 1; i < num_rows + 1; i++)
{
	draw_sprite(inv_sprite, 0, 
		global.inventory_x - border_size, 
		(i * border_size) + global.inventory_y - border_size);
	draw_sprite(inv_sprite, 1, 
		((num_cols + 1) * border_size) + global.inventory_x - border_size, 
		(i * border_size) + global.inventory_y - border_size);
}
#endregion

#region Draw the Inventory Slots
// DRAW THE ACTUAL INVENTORY SLOTS
for (var i = 0; i < ds_list_size(global.inventory); i ++)
{
	var slot_map = global.inventory[| i];
	var x_pos = slot_map[? "x"];
	var y_pos = slot_map[? "y"];
	//show_debug_message("SLOT #" + string(i) + " is at (" + string(x_pos) + ", " + string(y_pos) + ")");
	var slot_item = slot_map[? "item_id"];
	draw_sprite(inv_sprite, 8, x_pos, y_pos);
}
#endregion


var top_left_slot = global.inventory[| 0];
var bottom_right_slot = global.inventory[| ds_list_size(global.inventory) - 1];
	
if (mx >= top_left_slot[? "x"] && mx <= bottom_right_slot[? "x"] + border_size)
{
	if (my >= top_left_slot[? "y"] && my <= bottom_right_slot[? "y"] + border_size)
	{
		var col_num = floor( (mx - top_left_slot[? "x"]) / border_size );
		var row_num = floor( (my - top_left_slot[? "y"]) / border_size );
		//draw_text(mouse_screen_x, mouse_screen_y, "(" + string(col_num) + ", " + string(row_num) + ")");
		
		// row_num * num_of_columns gives us the # of slots per row
		var slot_index = col_num + (row_num * global.inventory_columns);
		var slot_map = global.inventory[| slot_index];
		if (slot_map[? "item_id"] != -1)
		{
			var slot_x = slot_map[? "x"];
			var slot_y = slot_map[? "y"];
			draw_sprite(inv_sprite, 9, slot_x, slot_y);
		}
	}
	
}*/














