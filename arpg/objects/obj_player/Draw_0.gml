gpu_set_blendmode(bm_add);
if (irandom(100) <= 4)
{
	light_x += choose(-1, 0, 1);
	light_y += choose(-1, 0, 1);
}

draw_sprite(spr_test_blendmode, 0, light_x, light_x);

gpu_set_blendmode(bm_normal);



draw_set_alpha(0.3);
draw_ellipse_color(x - (sprite_width / 2) - 2, y + (sprite_height / 2) - 3, 
	x + (sprite_width / 2) - 2, y + (sprite_height / 2), 
	col_shadow, col_shadow, false);
	
draw_set_alpha(1);

if (is_hurt)
{
	shader_set(shd_red);
	draw_self();
	shader_reset();
	is_hurt = false;
}
else if (is_deflecting)
{
	if (deflect_frame == 0)
	{
		shader_set(shd_flash);
		draw_self();
		shader_reset();
	}
	else draw_self();
	
	if (deflect_frame >= sprite_get_number(spr_player_deflect) - 1)
	{
		is_deflecting = false;
		deflect_frame = 0;
	}
	else
	{
		draw_sprite_ext(spr_player_deflect, round(deflect_frame), x, y, 1.2, 1.2, deflect_angle, c_white, 1);
		deflect_frame += 0.25;
	}

}
else if (is_dodging)
{
	var alpha = dodge_frame / 8;
	if (dodge_frame >= 8)
	{
		draw_self();
		is_dodging = false;
		dodge_frame = 1;
	}
	else
	{
		draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, alpha);
		dodge_frame += 1;
	}
}
else draw_self();

#region If Player Fires Bow, Animate Bow Firing
if (animating_bow)
{
	// choose the left or right facing sprite depending on the angle we're trying to shoot at
	// then add the direction vector of the mouse pos to the bow's angle so bow shoots 
	// at the correct angle wherever we click. we alter angle depending on sprite too.
	var bow_sprite;
	var bow_angle = point_direction(x, y, mouse_x, mouse_y);// - 17; //270->90, 
	if (bow_angle >= 270 || bow_angle <= 90) bow_sprite = spr_player_bow_right;
	else bow_sprite = spr_player_bow_left;
	
	if (bow_sprite == spr_player_bow_left) bow_angle -= 180 - 17;
	else bow_angle -= 17;

	draw_sprite_ext(bow_sprite, bow_frame, x, y, 
		1, 1, bow_angle, c_white, 1);
		
	if (bow_frame == sprite_get_number(spr_player_bow_right))
	{
		animating_bow = false;
		bow_frame = 0;
	}
	bow_frame += 1;
}
#endregion
