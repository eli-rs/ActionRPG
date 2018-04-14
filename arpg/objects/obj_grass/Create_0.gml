event_inherited();

image_speed = 0;
sprite_index = spr_grass_2;
if (random(1.0) <= 0.1)
	image_index = irandom_range(1, 4);//grass_sprites[| irandom_range(1, ds_list_size(grass_sprites) - 1)];
else image_index = 0;