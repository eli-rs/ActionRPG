
if (grid_pos_passed && global.room_created)
{
	for (var adj_x = -1; adj_x <= 1; adj_x ++)
	{
		for (var adj_y = -1; adj_y <= 1; adj_y ++)
		{
			if (adj_x != 0 || adj_y != 0)
			{
				var n_x = grid_x + adj_x;
				var n_y = grid_y + adj_y;
				if (n_x >= 0 && n_x < obj_room_generator.roomDimensions[0])
				{
					if (n_y >= 0 && n_y < obj_room_generator.roomDimensions[1])
					{
						var neighbor = global.tileGrid[n_x, n_y];
						// if the neighbor tile is grass set that to 0 in our grid
						if (neighbor == obj_grass || neighbor == obj_bush)
							neighbor_grid[# adj_x + 1, adj_y + 1] = 0;
						// if the neighbor tile is dirt set it to 1 in our grid
						else if (neighbor == obj_dirt)
							neighbor_grid[# adj_x + 1, adj_y + 1] = 1;
					}
				}			
			}
		}
	}
	//show_debug_message("neighbor grid: " + string(neighbor_grid));
	if (neighbor_grid[# 0, 1] == 1
		&& neighbor_grid[# 1, 0] == 1
		&& neighbor_grid[# 2, 1] == 1
		&& neighbor_grid[# 1, 2] == 1)
		image_index = 0;
	else if (neighbor_grid[# 0, 1] == 0 
		&& neighbor_grid[# 1, 0] == 1
		&& neighbor_grid[# 1, 2] == 1)
		image_index = choose(1, 24, 25, 26);
	else if (neighbor_grid[# 2, 1] == 0
		&& neighbor_grid[# 1, 0] == 1
		&& neighbor_grid[# 1, 2] == 1)
		image_index = choose(2, 27, 28, 29);
	else if (neighbor_grid[# 1, 0] == 0
		&& neighbor_grid[# 0, 1] == 1
		&& neighbor_grid[# 2, 1] == 1)
		image_index = choose(3, 30, 31, 32);
	else if (neighbor_grid[# 1, 2] == 0
		&& neighbor_grid[# 0, 1] == 1
		&& neighbor_grid[# 2, 1] == 1)
		image_index = choose(4, 33, 34, 35);
	else if (neighbor_grid[# 0, 1] == 0
		&& neighbor_grid[# 1, 0] == 0
		&& neighbor_grid[# 1, 2] == 1
		&& neighbor_grid[# 2, 1] == 1)
		image_index = 5;
	else if (neighbor_grid[# 1, 0] == 0
		&& neighbor_grid[# 2, 1] == 0
		&& neighbor_grid[# 0, 1] == 1
		&& neighbor_grid[# 1, 2] == 1)
		image_index = 6;
	else if (neighbor_grid[# 0, 1] == 0
		&& neighbor_grid[# 1, 2] == 0
		&& neighbor_grid[# 1, 0] == 1
		&& neighbor_grid[# 2, 1] == 1)
		image_index = 7;
	else if (neighbor_grid[# 2, 1] == 0
		&& neighbor_grid[# 1, 2] == 0
		&& neighbor_grid[# 0, 1] == 1
		&& neighbor_grid[# 1, 0] == 1)
		image_index = 8;
	else if (neighbor_grid[# 0, 0] == 1
		&& neighbor_grid[# 2, 2] == 0)
		image_index = 9;
	else if (neighbor_grid[# 2, 0] == 1
		&& neighbor_grid[# 0, 2] == 0)
		image_index = 10;
	else if (neighbor_grid[# 2, 0] == 0
		&& neighbor_grid[# 0, 2] == 1)
		image_index = 11;
	else if (neighbor_grid[# 0, 0] == 0
		&& neighbor_grid[# 2, 2] == 1)
		image_index = 12;
	else if (neighbor_grid[# 0, 0] == 0
		&& neighbor_grid[# 2, 2] == 0
		&& neighbor_grid[# 2, 0] == 1
		&& neighbor_grid[# 0, 2] == 1)
		image_index = choose(13, 14);
	else if (neighbor_grid[# 2, 0] == 0
		&& neighbor_grid[# 0, 2] == 0
		&& neighbor_grid[# 0, 0] == 1
		&& neighbor_grid[# 2, 2] == 1)
		image_index = choose(15, 16);
	
	if (image_index = 0 && random(1.0) <= 0.2)
		image_index = irandom_range(17, 23);
	
	grid_pos_passed = false;
}