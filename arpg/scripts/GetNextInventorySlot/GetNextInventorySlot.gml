var num_slots_to_check = ds_list_size(global.inventory);
for (var i = 0; i < num_slots_to_check; i++)
{
	var slot = global.inventory[| i];
	if (slot[? "item_id"] == -1)
	{
		return i;
	}
}

return noone;