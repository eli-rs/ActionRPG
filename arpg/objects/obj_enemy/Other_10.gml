/// @description On-Kill Effects
// LIFE ON KILL
if (global.player_stats[? derived_stats.life_on_kill] > 0)
{
	var current_health = obj_player.player_health_current;
	var life_on_kill = round(global.player_stats[? derived_stats.life] * 
		(global.player_stats[? derived_stats.life_on_kill] / 100));
	obj_player.player_health_current = min(global.player_stats[? derived_stats.life], 
		current_health + life_on_kill);

}
// MANA ON KILL
if (global.player_stats[? derived_stats.mana_on_kill] > 0)
{
	var current_mana = obj_player.player_mana_current;
	var mana_on_kill = round(global.player_stats[? derived_stats.mana] * 
		(global.player_stats[? derived_stats.mana_on_kill] / 100));
	obj_player.player_mana_current = min(global.player_stats[? derived_stats.mana], 
		current_mana + mana_on_kill);
}
// STAMINA ON KILL
if (global.player_stats[? derived_stats.stamina_on_kill] > 0)
{
	var current_stamina = obj_player.player_stamina_current;
	var stamina_on_kill = round(global.player_stats[? derived_stats.stamina] * 
		(global.player_stats[? derived_stats.stamina_on_kill] / 100));
	obj_player.player_stamina_current = min(global.player_stats[? derived_stats.stamina], 
		current_stamina + stamina_on_kill);
}
