
if (room == room_main)
{
	for (var i = 0; i < roomDimensions[0]; i++)
	{
		for (var j = 0; j < roomDimensions[1]; j++)
		{
			if (global.tileGrid[i, j] != noone) 
			{	
				if (global.tileGrid[i, j] == obj_bush)
				{
					instance_create_depth(i * tileSize, j * tileSize, depth + 1, obj_grass);
					instance_create_layer(i * tileSize, j * tileSize, "Layer_Objects", obj_bush);
				}
				else
				{
					var tile = instance_create_depth
						(i * tileSize, j * tileSize, depth, global.tileGrid[i, j])
					if (global.tileGrid[i, j].context_tile)
					{
						with(tile)
						{
							grid_x = i;
							grid_y = j;
							grid_pos_passed = true;
					
						}
					}
				}
			}
		}
	}
}

instance_create_layer(256, 256, "Layer_Objects", obj_player);