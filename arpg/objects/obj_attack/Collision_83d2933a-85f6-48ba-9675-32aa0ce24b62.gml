/// @description Insert description here

if (! ds_map_exists(unique_collisions, other))
{
	ds_map_add(unique_collisions, other, true);
	
	var enemy_deflect_chance = other.enemy_deflection;
	if (random(1.0) <= enemy_deflect_chance) 
	{
		var deflect_angle = irandom_range(80, 110);
		other.is_deflecting = true;
		other.deflect_angle = image_angle;
		other.deflect_size = other.sprite_height / sprite_get_height(spr_deflect);
		direction -= deflect_angle;
		image_angle -= deflect_angle;

	}
	else
	{
		// This simply makes it so on-hit events can not trigger other on-hit events
		if (triggered_by_skill == false)
		{
			// ON HIT EFFECTS HERE
			event_user(0);
		}
		else
		{
			total_damage = irandom_range(damage_range[0], damage_range[1]);
			
			if (random(1.0) <= crit_chance)
			{
				total_damage = round(crit_mult * total_damage);
				was_crit = true;
			}
		}
		other.is_flashing = true;
		if (other.is_hurt = false)
		{
			other.is_hurt = true;
			other.just_got_hurt = true;
		}
	
		#region Subtract Projectile's Damage from Enemies Health
		other.enemy_health_current -= total_damage;
		#endregion
	
		#region Pierce through Correct Number of Enemies
		// if enemies_pierced == -1 then they can pierce infinitely
		if (enemies_pierced != -1)
		{
			// otherwise, destroy the proj once it's pierced it's max num of enemies
			if (enemies_pierced == 0)
				instance_destroy();
			else 
				enemies_pierced -= 1;
		}
		#endregion
		
		
	
		#region Create Damage Text that Pops Up from Enemy
		// INSTANTIATE THE POPUP TEXT OBJECT AT THE PROPER POSITION
		// offset the popup text's x and y positions to accomodate the sprite
		var text_x = other.x;
		if (other.sprite_index == spr_enemy_glomper) text_x += 4;
		else if (other.sprite_index == spr_enemy_glomper_left) text_x -= 4;
	
		var text_y = other.y - (other.sprite_height * (2/3));
	
		var text_obj = instance_create_layer(text_x, text_y, "Layer_Objects", obj_damage_text);
		text_obj.damage = total_damage;
		text_obj.was_crit = was_crit;
		#endregion
	}
}
