
#region If Enemy is Bleeding, Draw & Animate Random Blood Sprite
if (is_bleeding)
{
	if (bleed_frame > sprite_get_number(blood_sprite) - 1)
	{
		is_bleeding = false;
		blood_sprite = global.blood_sprites[| irandom_range(0, ds_list_size(global.blood_sprites) - 1)];
		bleed_frame = 0;
	}
	else
	{
		draw_sprite(blood_sprite, bleed_frame, x, y);
		bleed_frame += 1;
	}
}
#endregion



#region Draw Enemy Health Bar When Health != MaxHealth
if (enemy_health_current < enemy_health_max)
{
	
	var health_y = y - (sprite_height / 2)
	draw_healthbar(
		x - 12, health_y,
		x + 12, health_y + 2, 
		(enemy_health_current / enemy_health_max) * 100, 
		c_black, health_color, health_color, 0, true, false);
	/*
	if (enemy_rarity == enemy_types.elite || enemy_rarity == enemy_types.boss)
	{
		// draw the health bar's border+back sprite
		draw_sprite(spr_gui_enemy_health, 1, x - 19, health_y - 2);

		// draw the light colored health bar line at top
		draw_healthbar(
			x - 16, health_y,
			x + 15, health_y, 
			(enemy_health_current / enemy_health_max) * 100, 
			c_black, health_color_light, health_color_light, 0, false, false);
		// draw the normal red colored health bar in the middle
		draw_healthbar(
			x - 16, health_y + 1,
			x + 16, health_y + 1, 
			(enemy_health_current / enemy_health_max) * 100, 
			c_black, health_color, health_color, 0, false, false);
		// draw the dark colored health bar line at the bottom
		draw_healthbar(
			x - 15, health_y + 2,
			x + 16, health_y + 2, 
			(enemy_health_current / enemy_health_max) * 100, 
			c_black, health_color_dark, health_color_dark, 0, false, false);
	}
	else if (enemy_rarity == enemy_types.common || enemy_rarity == enemy_types.uncommon)
	{
		draw_healthbar(
			x - 12, health_y,
			x + 12, health_y + 2, 
			(enemy_health_current / enemy_health_max) * 100, 
			c_black, health_color, health_color, 0, true, false);
	}
	else if (enemy_rarity == enemy_types.trash)
	{

		draw_healthbar(
			x - 8, health_y + 1,
			x + 8, health_y + 2, 
			(enemy_health_current / enemy_health_max) * 100, 
			c_black, health_color, health_color, 0, true, false);

	}
	*/
}
#endregion

#region Draw Enemy Detection Circle
draw_set_alpha(0.04);
if (enemy_has_detected_player)
	draw_circle_color(x, y, enemy_detection_range, c_black, c_black, false);
else
	draw_circle_color(x, y, enemy_detection_range, c_white, c_white, false);
draw_set_alpha(1);
#endregion

// EVERYTHING BEFORE HERE WILL DRAW BEHIND THE ENEMY 

if (is_flashing)
{
	shader_set(shd_red);
	draw_self();
	shader_reset();
	is_flashing = false;
}
else draw_self();
 
 // EVERYTHING AFTER HERE WILL DRAW IN FRONT OF THE ENEMY
 
if (enemy_has_detected_player)
{
	if (enemy_detection_time > 0)
	{
		draw_text_transformed_color(x, y - (sprite_height * (4/5)), "!", 0.6, 0.6, 0, c_red, c_red, c_red, c_red, 1);
		enemy_detection_time -= 1;
	}
}

if (is_deflecting)
{
	if (deflect_frame > sprite_get_number(spr_deflect) - 1)
	{
		is_deflecting = false;
		deflect_frame = 0;
	}
	else
	{
		var deflect_x = x;
		if (name == "spr_ogre")// || name == "spr_ogre_blue")
		{
			if (last_direction == 1)
				deflect_x -= 8;
			else if (last_direction == -1)
				deflect_x += 8;
		}
		draw_sprite_ext(spr_deflect, round(deflect_frame), deflect_x, y,
			deflect_size, deflect_size, deflect_angle - 45, c_white, 1);
		deflect_frame += 0.75;
	}
	
}