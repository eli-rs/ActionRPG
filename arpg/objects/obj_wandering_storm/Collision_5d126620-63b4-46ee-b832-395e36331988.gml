
if (tick_timer <= 0)
{
	// determine whether hit was crit, and then determine damage
	var was_crit = (random(1.0) <= crit_chance);
	var skill_damage = irandom_range(damage_range[0], damage_range[1]);
	if (was_crit) skill_damage = round(skill_damage * crit_mult);
	other.enemy_health_current -= skill_damage;

	
	// offset the popup text's x and y positions to accomodate the sprite
	text_x = other.x;
	if (other.sprite_index == spr_enemy_glomper) text_x += 4;
	else if (other.sprite_index == spr_enemy_glomper_left) text_x -= 4;
	
	text_y = other.y - (other.sprite_height * (2/3));
	// INSTANTIATE THE POPUP TEXT OBJECT AT THE PROPER POSITION
	var text_obj = instance_create_layer(text_x, text_y, "Layer_Objects", obj_damage_text);
	text_obj.damage = skill_damage;
	text_obj.was_crit = was_crit;
	
	tick_timer = tick_rate;
}