/*
 *		Inventory is ds_list global.inventory, containing ds_maps which hold the following:
 *	"x"			: the x coordinate of the inventory slot
 *	"y"			: the y coordinate of the inventory slot
 *	"id"		: the index within global.inventory of the current slot, i.e. slot = global.inventory[| id];
 *	"item_id"	: the index within global.items of the item currently in this slot, i.e. item_in_slot = global.items[|item_id];


*/

var num_rows = argument0;
var num_columns = argument1;

global.inventory_rows = num_rows;
global.inventory_columns = num_columns;

var start_x = argument2; // starting x?
var start_y = argument3; // starting y?

global.inventory_x = start_x;
global.inventory_y = start_y;

var slot_size = sprite_get_width(spr_inventory_border);

global.inventory = ds_list_create();

for (var i = 0; i < num_rows; i ++){
	for (var j = 0; j < num_columns; j ++){
		
		var cell_map = ds_map_create();
		var slot_x = start_x + (j * slot_size); //this = roughly how many pixels horizontally in we are + xx
		var slot_y = start_y + (i * slot_size); // how many pixels down vertically we are + yy
		
		ds_map_add(cell_map, "x", slot_x);
		ds_map_add(cell_map, "y", slot_y);
		ds_map_add(cell_map, "id", ds_list_size(global.inventory));
		ds_map_add(cell_map, "item_id", -1);
		
		ds_list_add(global.inventory, cell_map);
		
	}
}


// initialize and populate items database
global.items = ds_list_create();
global.loot_table = ds_map_create();

CreateItemDatabase(); //AddItemToDatabase();

/*
name
value
description
attributes
*/















