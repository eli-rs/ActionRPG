//event_inherited();

image_speed = 0;
sprite_index = choose(spr_shrubbery, spr_logs, spr_bush_stump, spr_trees);
if (sprite_index = spr_shrubbery)
	image_index = irandom_range(0, 10);
else if (sprite_index = spr_logs)
	image_index = choose(0, 1);
else if (sprite_index = spr_bush_stump)
	image_index = choose(0, 1, 2);
else if (sprite_index = spr_trees)
	image_index = choose(0, 1);