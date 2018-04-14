if (has_collided == false)
{
	has_collided = true;
	var plvl = other.player_level;
	var pdeflect = global.player_stats[? derived_stats.armor_deflection];
	
	
	accuracy = level * 45;
	
	//show_debug_message("deflect: " + string(pdeflect) + ", absorb: " + string(pabsorb) + ", accuracy:" + string(accuracy) + ", monst level: " + string(level));
	// check to see if attack is deflected
	var deflect_chance = ( (70 * pdeflect)/(pdeflect + accuracy) ) * ( (2 * plvl)/(plvl + level) );
	//show_debug_message("deflect chance: " + string(deflect_chance))
	if (random(1.0) <= deflect_chance/100)
	{
		// ANY ON-DEFLECTION EVENTS HERE!!
		other.is_deflecting = true;
		other.deflect_angle = image_angle - 180;
		enemy_id.is_melee_attacking = false;
		enemy_id.inactive = false;
		instance_destroy();
	}
	else
	{
		if (random(1.0) <= global.player_stats[? derived_stats.dodge] / 100)
		{
			// ANY ON-DODGE EVENTS HERE!!
			other.is_dodging = true;
			instance_destroy();
		}
		else
		{
			
			var pabsorb = global.player_stats[? derived_stats.armor_absorption];
			var absorb_percent = ( (100 * pabsorb)/(pabsorb + accuracy) ) * ( (2 * plvl)/(plvl + level) );
			// CHECK FOR PLAYER WEARING SHIELD AND PLAYER DUAL-WIELDING
			// IF EITHER OF THOSE, DO CHECK FOR SHIELD BLOCK/PARRY BLOCK
			
			// IF WE SUCCESSFULLY HIT PLAYER:
			event_user(0);
			var was_crit = (random(1.0) <= crit_chance);
			var damage = irandom_range(damage_range[0], damage_range[1]);
			if (was_crit) 
			{
				damage = round(damage * crit_mult);
				// ADD ANY ON-ENEMY-CRIT EVENTS HERE!!
			}
			
			
			var damage_absorbed = (absorb_percent / 100) * damage;
			
			var damage_taken = round(damage - damage_absorbed);
			
			other.is_hurt = true;
			other.player_health_current -= damage_taken;
			other.absorbing = damage_absorbed;
			// ADD ANY DAMAGE-TAKEN EVENTS HERE!!
			
	
			// offset the popup text's x and y positions to accomodate the sprite
			text_x = other.x;	
			text_y = other.y - (other.sprite_height * (2/3));
			// INSTANTIATE THE POPUP TEXT OBJECT AT THE PROPER POSITION
			var text_obj = instance_create_layer(text_x, text_y, other.layer, obj_damage_text_enemy);
			text_obj.damage = damage_taken;
			text_obj.was_crit = was_crit;
		}
	}
	
	
}
// PLAYER CHANCE TO HIT A MONSTER
/*		120 * MyAttack			        2 * MyLvl
//     ------------------       x     ------------------
//	  MyAttack + TheirDefense         (MyLvl + TheirLvl)
//
*/  // clamped between 5% chance to hit and 95% chance to hit
//
// PLAYER CHANCE TO DEFLECT MONSTER HIT
//
//		70 * Deflect			        2 * MyLvl
//     ------------------       x     ------------------
//	  MonstAtk + Deflect           (MyLvl + TheirLvl)
//
//	// capped at 75% chance to deflect the blow
//
//















