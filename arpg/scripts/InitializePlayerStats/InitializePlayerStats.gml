


enum derived_stats {
	life,
	mana,
	stamina,
	life_regen,
	mana_regen,
	stamina_regen,
	life_steal,
	mana_steal,
	life_per_hit,
	mana_per_hit,
	life_on_kill,
	mana_on_kill,
	stamina_on_kill,
	attack_damage,
	spell_damage,
	immunity_to_status_effect,
	reduced_duration_to_status_effect,
	strength,
	dexterity,
	constitution,
	intelligence,
	cast_skill_when_struck,
	cast_skill_on_striking,
	armor_deflection,
	armor_absorption,
	shield_recovery_time,
	shield_chance_to_block,
	
	parry_damage_blocked,
	parry_chance_to_block,
	dodge,
	movement_speed,
	magic_find,
	attack_cooldown_reduction,
	spell_cooldown_reduction,
	
	critical_hit_chance,
	critical_hit_damage,
	accuracy,
	recovery_rate,
	stagger,
	absorption_duration,
	
	//	STATS TO ADD:
//	recovery_rate			(speeds up animation speed of 'hurt_anim')
//	stagger_amount			(slows down animation speed of 'hurt_anim' for enemies)
//	accuracy				(like attack rating, determines chance to hit 
//	absorption duration		(increases length of time that absorbed damage is distributed over)

}
/*
		mobility_skill_speed,				// percent increased
	mobility_skill_length,				// percent increased
	mobility_skill_cooldown,			// percent reduced
	dash_speed,							// percent increased
	dash_length,						// percent increased
	// 50 mods
	dash_cooldown,						// percent reduced
	attack_skill_duration,				// percent increased
	attack_skill_aoe,					// percent increased
	attack_skill_projectiles,			// percent increased
	spell_skill_duration,				// percent increased
	spell_skill_aoe,					// percent increased
	spell_skill_projectiles,			// percent increased
	skill_duration,						// percent increased
	skill_aoe,							// percent increased
	skill_projectiles,					// percent increased
	aura_aoe,							// percent increased
	aura_potency,						// percent increased
	
	
}*/



global.player_stats = ds_map_create();

global.player_stats[? derived_stats.life] = 0;
global.player_stats[? derived_stats.mana] = 0
global.player_stats[? derived_stats.stamina] = 0


global.player_stats[? derived_stats.life_regen] = 0;
global.player_stats[? derived_stats.mana_regen] = 0;
global.player_stats[? derived_stats.stamina_regen] = 0;


global.player_stats[? derived_stats.life_steal] = 0;
global.player_stats[? derived_stats.mana_steal] = 0;


global.player_stats[? derived_stats.life_per_hit] = 0;
global.player_stats[? derived_stats.mana_per_hit] = 0;


global.player_stats[? derived_stats.life_on_kill] = 0;
global.player_stats[? derived_stats.mana_on_kill] = 0;
global.player_stats[? derived_stats.stamina_on_kill] = 0;


global.player_stats[? derived_stats.attack_damage] = noone;
global.player_stats[? derived_stats.spell_damage] = noone


global.player_stats[? derived_stats.immunity_to_status_effect] = ds_list_create();
global.player_stats[? derived_stats.reduced_duration_to_status_effect] = ds_list_create();


global.player_stats[? derived_stats.strength] = 0;
global.player_stats[? derived_stats.dexterity] = 0;
global.player_stats[? derived_stats.constitution] = 0;
global.player_stats[? derived_stats.intelligence] = 0;


global.player_stats[? derived_stats.cast_skill_when_struck] = ds_list_create();
global.player_stats[? derived_stats.cast_skill_on_striking] = ds_list_create();


global.player_stats[? derived_stats.armor_deflection] = 0;
global.player_stats[? derived_stats.armor_absorption] = 0;


global.player_stats[? derived_stats.shield_recovery_time] = 0;
global.player_stats[? derived_stats.shield_chance_to_block] = 0;


global.player_stats[? derived_stats.parry_damage_blocked] = 0;
global.player_stats[? derived_stats.parry_chance_to_block] = 0;


global.player_stats[? derived_stats.dodge] = 0;
global.player_stats[? derived_stats.movement_speed] = 0;
global.player_stats[? derived_stats.magic_find] = 0;

global.player_stats[? derived_stats.attack_cooldown_reduction] = 0;
global.player_stats[? derived_stats.spell_cooldown_reduction] = 0;

global.player_stats[? derived_stats.critical_hit_chance] = 0;
global.player_stats[? derived_stats.critical_hit_damage] = 0;

global.player_stats[? derived_stats.accuracy] = 0;
global.player_stats[? derived_stats.recovery_rate] = 0;
global.player_stats[? derived_stats.stagger] = 0;
global.player_stats[? derived_stats.absorption_duration] = 0;


//	STATS TO ADD:
//	recovery_rate			(speeds up animation speed of 'hurt_anim')
//	stagger_amount			(slows down animation speed of 'hurt_anim' for enemies)
//	accuracy				(like attack rating, determines chance to hit 
//	absorption duration		(increases length of time that absorbed damage is distributed over)


/*
global.player_stats[? derived_stats.mobility_skill_speed] = ds_map_create();		
global.player_stats[? derived_stats.mobility_skill_length] = ds_map_create();		
global.player_stats[? derived_stats.mobility_skill_cooldown] = ds_map_create();	
global.player_stats[? derived_stats.attack_skill_duration] = ds_map_create();	
global.player_stats[? derived_stats.attack_skill_aoe] = ds_map_create();	
global.player_stats[? derived_stats.attack_skill_projectiles] = ds_map_create();	
global.player_stats[? derived_stats.spell_skill_duration] = ds_map_create();	
global.player_stats[? derived_stats.spell_skill_aoe] = ds_map_create();	
global.player_stats[? derived_stats.spell_skill_projectiles] = ds_map_create();	
global.player_stats[? derived_stats.skill_duration] = ds_map_create();	
global.player_stats[? derived_stats.skill_aoe] = ds_map_create();	
global.player_stats[? derived_stats.skill_projectiles] = ds_map_create();	
global.player_stats[? derived_stats.aura_aoe] = ds_map_create();	
global.player_stats[? derived_stats.aura_potency] = ds_map_create();	
*/
