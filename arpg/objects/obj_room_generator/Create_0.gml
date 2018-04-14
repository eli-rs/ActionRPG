// room size
global.room_created = false;

roomDimensions = [180, 90];
tileSize = 16;

roomWidth = roomDimensions[0] * tileSize;
roomHeight = roomDimensions[1] * tileSize;

room_set_width(room_main, roomWidth);
room_set_height(room_main, roomHeight);

// place walls

global.tileGrid[roomDimensions[0], roomDimensions[1]] = 0;
wallChance = 0.125;

for (var i = 0; i < roomDimensions[0]; i++)
{
	for (var j = 0; j < roomDimensions[1]; j++)
	{
		if (random(1.0) <= 0.02)
			global.tileGrid[i, j] = obj_bush;
		else
			global.tileGrid[i, j] = obj_grass;
	}
}
var dirt_block_freq = 6; // block of dirt will occur once within every 10x10 squares of grass
for (var i = 0; i <= roomDimensions[0] / dirt_block_freq; i++)
{
	var min_x = i * dirt_block_freq;
	var max_x = (i * dirt_block_freq) + dirt_block_freq - 1;
	
	for (var j = 0; j <= roomDimensions[1] / dirt_block_freq; j++)
	{
		var min_y = j * dirt_block_freq;
		var max_y = (j * dirt_block_freq) + dirt_block_freq - 1;
		
		var block_width = irandom_range(2, dirt_block_freq - 1);
		var block_height = irandom_range(2, dirt_block_freq - 1);
		
		var loc_x_max = max_x - block_width;
		var loc_y_max = max_y - block_height;
		
		var block_x = irandom_range(min_x, loc_x_max);
		var block_y = irandom_range(min_y, loc_y_max);
		
		for (var bx = 0; bx < block_width; bx++)
		{
			for (var by = 0; by < block_height; by++)
			{
				global.tileGrid[block_x + bx, block_y + by] = obj_dirt;
			}
		}
	}
}


global.room_created = true;


// proceed to next room
room_goto(room_main);






















/*
for (var i = 0; i < roomDimensions[0]; i++)
{
	for (var j = 0; j < roomDimensions[1]; j++)
	{
		global.tileGrid[i, j] = obj_dirt;
		if (random(1.0) <= wallChance) 
		{
			global.tileGrid[i, j] = obj_grass;
		}
	}
}

numIterations = 4;


// for each tile in grid
for (var iter = 0; iter < numIterations; iter++)
{
	gridCopy = global.tileGrid;
	for (var i = 1; i < roomDimensions[0] - 1; i++)
	{
		for (var j = 1; j < roomDimensions[1] - 1; j++)
		{
			if (global.tileGrid[i, j] == obj_grass) continue;
			// check each neihbor 
			tally = 0.0;
			for (var xOff = -1; xOff <= 1; xOff++)
				for (var yOff = -1; yOff <= 1; yOff++)
				{
					if (xOff != 0 || yOff != 0)
						if (global.tileGrid[i + xOff, j + yOff] == obj_grass) tally += wallChance;
				}
			
			if (tally >= 0.75) 
			{
				if (random(1.0) >= 0.5)
					gridCopy[i, j] = obj_bush;
				else
					gridCopy[i, j] = obj_grass;
				
			}
			else 
			{
			
				if (iter == 2 && tally > 0.4) tally = 0.4;
				if (iter >= 3 && tally > 0.25) tally = 0.25;
				
			
			//else if (iter == 3) tally = tally * (0.5);
			
				if (random(1.0) <= tally) gridCopy[i, j] = obj_grass;
			}
		}
	}
	global.tileGrid = gridCopy;
}
*/








