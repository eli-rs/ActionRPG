event_inherited();
/*
if (has_collided == false)
{
	// WHEN WE HIT THE PLAYER FOR THE FIRST TIME: APPLY DAMAGE, KNOCKBACK, &OTHER EFFECTS
	// determine whether hit was crit, and then determine damage
	var was_crit = (random(1.0) <= hitbox_crit_chance);
	var hitbox_damage = irandom_range(hitbox_damage_range[0], hitbox_damage_range[1]);
	if (was_crit) hitbox_damage = round(hitbox_damage * hitbox_crit_mult);
	other.player_health_current -= hitbox_damage;
	other.x += hitbox_knockback_x;
	other.y += hitbox_knockback_y;
	has_collided = true;
	
	// UNCOMMENT BELOW IF WE WANT DAMAGE POPUPS WHEN PLAYER IS HIT
	
	// offset the popup text's x and y positions to accomodate the sprite
	text_x = other.x;	
	text_y = other.y - (other.sprite_height * (2/3));
	// INSTANTIATE THE POPUP TEXT OBJECT AT THE PROPER POSITION
	var text_obj = instance_create_layer(text_x, text_y, other.layer, obj_damage_text_enemy);
	text_obj.damage = hitbox_damage;
	text_obj.was_crit = was_crit;
	
}*/