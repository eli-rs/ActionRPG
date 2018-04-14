/*


surface_set_target(surf);

draw_set_color(c_black);

current_alpha += alpha_step;
if (dusk_timer > 1)
{
	draw_set_alpha(current_alpha);
	dusk_timer -= 1;
}
else
	draw_set_alpha(0.75);
	
draw_rectangle(obj_player.x - global.view_width, obj_player.y - global.view_height, 
	obj_player.x + global.view_width, obj_player.y + global.view_height, false);

gpu_set_blendmode(bm_subtract);
draw_set_color(c_white);
draw_set_alpha(1);

draw_circle(obj_player.x, obj_player.y, 72 + random_range(-1, 1), false);

var num_fires = instance_number(obj_campfire);
for (var i = 0; i < num_fires; i++)
{
	var fire = instance_find(obj_campfire, i);
	draw_sprite(spr_lighting_mask, irandom_range(0, 3), fire.x + (fire.sprite_width / 2), fire.y + (fire.sprite_height / 2));

}

gpu_set_blendmode(bm_normal);

surface_reset_target();

