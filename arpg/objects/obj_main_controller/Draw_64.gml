//=============================LEVEL UP===========================
#region Draw Interactive Level Up GUI When Player Gains Level
if (level_up)
{
	var mouse_screen_x = mouse_x - (obj_smooth_view.x);
	var mouse_screen_y = mouse_y - (obj_smooth_view.y)
	mouse_screen_x += 193;
	mouse_screen_y += 109;
	var num_bubbles = 3;

	if (global.inventory_open) global.inventory_open = false;
	draw_sprite(spr_gui_levelup, 0, 0, 0);
	if (mouse_screen_x >= 138 && mouse_screen_x <= 190)
	{
		if (mouse_screen_y >= 140 && mouse_screen_y <= 160)
		{
			draw_sprite(spr_gui_levelup, 1, 0, 0);
			if (mouse_check_button_pressed(mb_left))
			{
				if (attribute_points == 0)
				{
					
					clicked_spend = true;
						//level_up = false;
				}
				else
					display_warning = true;
			}
			
		}
	}
	if (clicked_spend)
	{
		draw_sprite(spr_gui_levelup, 2, 0, 0);
		if (mouse_check_button_released(mb_left) && clicked_spend)
		{
			//draw_sprite(spr_gui_levelup, 2, 0, 0);
			level_up = false;	
			var str = 0;
			var dex = 0;
			var con = 0;
			for (var row = 0; row < ds_grid_height(attr_grid); row ++)
			{
				for (var col = 0; col < ds_grid_width(attr_grid); col ++)
				{
					var val = attr_grid[# row, col];
		
					if (row == 0)
					{
						if (val == 2) str++;
					}
					else
					{
						if (row == 1 && val == 2) dex++;	
						else
						{
							if (row == 2 && val == 2) con ++;
						}
					}

				}
			}
			obj_player.player_strength += str;
			obj_player.player_dexterity += dex;
			obj_player.player_constitution += con;

			LevelUp();
			
		}
	}
			
	// bubble locations
	//x180->209, y51->90
	var xmin = 180 - 2;
	var xmax = 209 + 2;
	var ymin = 51;
	var ymax = 90;
	
	var colw = (xmax - xmin) / num_bubbles;
	var rowh = (ymax - ymin) / num_bubbles;

			

	draw_text_transformed_color(154, 42, "Remaining points: " + string(attribute_points), 
		0.2, 0.2, 0, color_attr_points, color_attr_points, color_attr_points, color_attr_points, 1);
	
	if (display_warning)
	{
		draw_text_transformed_color(127, 132, "Spend all attribute points first!",
			0.15, 0.15, 0, c_red, c_red, c_red, c_red, 1);
	}
		
	if (attribute_points == 0)
		display_warning = false;
		
	for (var row = 0; row < ds_grid_height(attr_grid); row++)
	{
		for (var col = 0; col < ds_grid_width(attr_grid); col++)
		{
			draw_sprite(spr_gui_bubbles, attr_grid[# row, col], xmin + 2 + (colw * col), ymin + 1 + (row * 16));
		}
	}
	//draw_text(mouse_screen_x, mouse_screen_y, string(mouse_screen_x) + ", " + string(mouse_screen_y))
	if (mouse_check_button_pressed(mb_left))
	{
		if (mouse_screen_x >= xmin && mouse_screen_x <= xmax)
		{
			if (mouse_screen_y >= ymin && mouse_screen_y <= ymax)
			{
				var bx = floor( (mouse_screen_x - xmin) / colw);
				var by = 0;
				
				
				if (mouse_screen_y <= 62)
					by = 0;
				else if (mouse_screen_y >= 63 && mouse_screen_y <= 78)
					by = 1;
				else if (mouse_screen_y >= 79 && mouse_screen_y <= 90)
					by = 2;
				var current = attr_grid[# by, bx];
				if (current == 1)
				{
					if (attribute_points > 0)
					{
						attr_grid[# by, bx] = 2;
						attribute_points -= 1;
						if (bx < 2)
							attr_grid[# by, bx + 1] = 1;
					}
					
				}
				else if (current == 2 && attr_grid[# by, bx + 1] != 2)
				{
					attr_grid[# by, bx] = 1;
					attr_grid[# by, bx + 1] = 0;
					attribute_points += 1;
				}

			}
		}
	}

}
#endregion



#region Draw GUI for Portrait, Health Bar, and Stamina Bar, Experience Bar, and Skill Cooldown Bars
if (global.in_game)
{

	// DRAW PORTRAIT
	draw_sprite(spr_portraits, 4, portrait_x, portrait_y);
	// DRAW HEALTH/STAMINA/PORTRAIT GUI
	draw_sprite(spr_gui_health_mana_portrait, 0, health_gui_x, health_gui_y);
	
	var skill_width = 13; 
	for (var i = 0; i < ds_list_size(global.player_skills); i++)
	{
		var skill_map = global.player_skills[| i];
		var skill_reset_time = skill_map[? "cooldown"] * game_get_speed(gamespeed_fps);
		draw_sprite(skill_map[? "sprite_index"], skill_map[? "image_index"], 
			skillbar_gui_x + (skill_width * i), skillbar_gui_y);
		draw_set_alpha(0.5);
		draw_healthbar(skillbar_gui_x + (skill_width * i), skillbar_gui_y, skillbar_gui_x + (skill_width * i) + 11, skillbar_gui_y + 11, 
			(skill_map[? "timer"] / skill_reset_time) * 100,
			c_black, c_white, c_white, 3, false, false);
		draw_set_alpha(1);
	}
	
	// DRAW COOLDOWN BOXES FOR BOTH THE LEFT AND RIGHT MOUSE CLICK ATTACKS
	var cooldown_x = health_gui_x  - 60;
	var cooldown_y = health_gui_y - 28;
	
	draw_sprite(spr_icons_tiny_items, 0, cooldown_x, cooldown_y);
	draw_sprite(spr_icons_tiny_items, 1, cooldown_x + 13, cooldown_y);
	draw_set_alpha(0.5);
	draw_healthbar(cooldown_x, cooldown_y, cooldown_x + 10, cooldown_y + 10, 
	(obj_player.player_melee_attack_timer / obj_player.player_melee_attack_reset_time) * 100,
	c_black, c_white, c_white, 3, false, false);
	draw_healthbar(cooldown_x + 13, cooldown_y, cooldown_x + 23, cooldown_y + 10, 
	(obj_player.player_ranged_attack_timer / obj_player.player_ranged_attack_reset_time) * 100,
	c_black, c_white, c_white, 3, false, false);
	draw_set_alpha(1);
	
	draw_sprite_ext(spr_items_potion, 0, 
		health_gui_x - 24 + (sprite_get_width(spr_gui_health_mana_portrait) / 2), 
		health_gui_y - 10, 0.5, 0.5, 0, c_white, 
		max(0.2, 1 - (obj_player.player_potion_reset_timer / obj_player.player_potion_reset_time)));

	// DRAW HEALTH BAR
	var health_xscale = (obj_player.player_health_current / global.player_stats[? derived_stats.life])
	var health_loss_xscale = (obj_player.player_health_back_current / global.player_stats[? derived_stats.life])

	var health_x = portrait_x + 22;
	var health_y = portrait_y + 1;
	
	///////////////
	draw_healthbar(health_x, health_y, 
		health_x + sprite_get_width(spr_gui_resource_bars) - 2, 
		health_y, health_loss_xscale * 100, c_black, 
		col_health_loss_light, col_health_loss_light, 0, false, false);
		
	draw_healthbar(health_x, health_y + 1, 
		health_x + sprite_get_width(spr_gui_resource_bars) - 1, 
		health_y + 2, health_loss_xscale * 100, c_black, 
		col_health_loss, col_health_loss, 0, false, false);

	draw_healthbar(health_x + 1, health_y + 3, 
		health_x + sprite_get_width(spr_gui_resource_bars) - 1, 
		health_y + 3, health_loss_xscale * 100, c_black, 
		col_health_loss_dark, col_health_loss_dark, 0, false, false);
	
	///////////////
	draw_healthbar(health_x, health_y, 
		health_x + sprite_get_width(spr_gui_resource_bars) - 2, 
		health_y, health_xscale * 100, c_black, 
		color_health_light, color_health_light, 0, false, false);
	
	draw_healthbar(health_x, health_y + 1, 
		health_x + sprite_get_width(spr_gui_resource_bars) - 1, 
		health_y + 2, health_xscale * 100, c_black, 
		color_health, color_health, 0, false, false);
	
	draw_healthbar(health_x + 1, health_y + 3, 
		health_x + sprite_get_width(spr_gui_resource_bars) - 1, 
		health_y + 3, health_xscale * 100, c_black, 
		color_health_dark, color_health_dark, 0, false, false);

	
	// DRAW THE TEXT OF CURRENT HEALTH ON TOP OF HEALTH BAR
	draw_set_halign(fa_center);
	draw_text_transformed_color(health_x + (sprite_get_width(spr_gui_resource_bars) / 2), health_y, 
		string(round(obj_player.player_health_current)) + "/" + string(global.player_stats[? derived_stats.life]), 0.15, 0.15, 0,
		c_white, c_white, c_white, c_white, 1);
	//draw_sprite_ext(spr_gui_resource_bars, 0, health_x, health_y, 
		//health_xscale, 1, 0, c_white, 255);	
		
	var stamina_xscale = (obj_player.player_stamina_current / obj_player.player_stamina_max)
	var stamina_x = portrait_x + 23;
	var stamina_y = portrait_y + 8;


	draw_healthbar(stamina_x, stamina_y, 
		stamina_x + sprite_get_width(spr_gui_resource_bars) - 2, 
		stamina_y, stamina_xscale * 100, c_black, 
		color_stamina_light, color_stamina_light, 0, false, false);
	
	draw_healthbar(stamina_x, stamina_y + 1, 
		stamina_x + sprite_get_width(spr_gui_resource_bars) - 2, 
		stamina_y + 2, stamina_xscale * 100, c_black, 
		color_stamina, color_stamina, 0, false, false);
	
	draw_healthbar(stamina_x, stamina_y + 3, 
		stamina_x + sprite_get_width(spr_gui_resource_bars) - 3, 
		stamina_y + 3, stamina_xscale * 100, c_black, 
		color_stamina_dark, color_stamina_dark, 0, false, false);

	draw_text_transformed_color(health_x + (sprite_get_width(spr_gui_resource_bars) / 2), health_y + 7, 
	string(obj_player.player_stamina_current) + "/" + string(obj_player.player_stamina_max), 0.15, 0.15, 0,
	c_white, c_white, c_white, c_white, 1);

//=====================DRAW EXPERIENCE BAR AT BOTTOM OF SCREEN===================
	xp_sprite_y = global.view_height - 12;
	draw_sprite(spr_gui_exp_bar, 0, 55, xp_sprite_y);
	draw_healthbar(63, xp_sprite_y + 6, 293, xp_sprite_y + 6, 
		(obj_player.player_experience_current / obj_player.player_experience_needed) * 100, 
		c_black, color_xp_light, color_xp_light, 0, false, false);
	draw_healthbar(63, xp_sprite_y + 7, 294, xp_sprite_y + 8, 
		(obj_player.player_experience_current / obj_player.player_experience_needed) * 100, 
		c_black, color_xp_normal, color_xp_normal, 0, false, false);
	draw_healthbar(64, xp_sprite_y + 9, 293, xp_sprite_y + 9, 
		(obj_player.player_experience_current / obj_player.player_experience_needed) * 100, 
		c_black, color_xp_dark, color_xp_dark, 0, false, false);
}
#endregion


if (global.inventory_open) 
{	
	var mouse_screen_x = mouse_x - (obj_smooth_view.x);
	var mouse_screen_y = mouse_y - (obj_smooth_view.y)
	mouse_screen_x += 193;
	mouse_screen_y += 109;

	DrawInventory(mouse_screen_x, mouse_screen_y);
}

if (global.character_sheet_open)
{
	DrawCharacterSheet();
}