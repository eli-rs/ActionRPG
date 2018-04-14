/// @description All Per Second Events

player_health_current = min(global.player_stats[? derived_stats.life], player_health_current + global.player_stats[? derived_stats.life_regen])

player_mana_current = min(global.player_stats[? derived_stats.mana], player_mana_current + global.player_stats[? derived_stats.mana_regen])

if (absorbed_damage[| 0] != 0)
{
	var damage_per_second = absorbed_damage[| 0];
	player_health_current -= damage_per_second;
	ds_list_delete(absorbed_damage, 0);
	ds_list_add(absorbed_damage, 0);
	
	if (round(damage_per_second) > 0)
	{
		var text_x = x;
		var text_y = y - (sprite_height * (2/3));
		var text_obj = instance_create_layer(text_x, text_y, "Layer_Objects", obj_damage_text_mini);
		text_obj.damage = round(damage_per_second);
	}
}