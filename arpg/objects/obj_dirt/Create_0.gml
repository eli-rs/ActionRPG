image_speed = 0;
context_tile = true;

grid_pos_passed = false;

grid_x = -1;
grid_y = -1;
neighbor_grid = ds_grid_create(3, 3);
for (var i = 0; i < 3; i++){
	for (var j = 0; j < 3; j ++){
		neighbor_grid[# i, j] = -1;
	}
}



