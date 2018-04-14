
global.crit_chance_base = 0.1;
global.crit_mult_base = 1.5;

enum stats {
	life = 0,								// flat amount
	mana = 1,								// flat amount
	stamina = 2,							// flat amount
	life_percent = 3,						// percent increased
	mana_percent = 4,						// percent increased
	stamina_percent = 5,					// percent increased
	life_regen = 6,							// flat amount per second
	mana_regen = 7,							// flat amount per second
	stamina_regen = 8,						// flat amount per second
	life_regen_speed = 9,					// percent increased 
	
	mana_regen_speed = 10,					// percent increased
	stamina_regen_speed = 11,				// percent increased
	life_steal = 12,							// percent amount
	mana_steal = 13,							// percent amount
	life_per_hit = 14,						// flat amount
	mana_per_hit = 15,						// flat amount
	life_on_kill = 16,						// percent amount
	mana_on_kill = 17,						// percent amount
	stamina_on_kill = 18,					// percent amount
	all_skills = 19,							// flat amount
	
	class_skills = 20,						// flat amount, class
	class_skill_tree = 21,					// flat amount, skill tree
	specific_skill = 22,						// flat amount, skill
	damage_to_attacks = 23,					// flat minimum, flat maximum
	damage_to_spells = 24,					// flat minimum, flat maximum
	immunity_to_status_effect = 25,			// status effect
	reduced_duration_to_status_effect = 26,	// percent reduced, status effect
	strength = 27,							// flat amount
	dexterity = 28,							// flat amount
	constitution = 29,						// flat amount
	
	intelligence = 30,						// flat amount
	all_attributes = 31,						// flat amount
	cast_skill_when_struck = 32,				// skill, skill level, chance
	cast_skill_on_striking = 33,				// skill, skill level, chance
	armor_deflection = 34,					// flat amount
	armor_absorption = 35,					// flat amount
	enhanced_deflection = 36,				// percent enhanced
	enhanced_absorption = 37,				// percent enhanced 
	shield_recovery_time = 38,				// percent reduced
	shield_chance_to_block = 39,				// percent chance
	
	parry_damage_blocked = 40,				// flat amount
	parry_effectiveness = 41,				// percent increased damage blocked
	parry_chance_to_block = 42,				// percent chance
	dodge = 43,								// percent chance
	movement_speed = 44,						// percent increased
	magic_find = 45,							// percent increased
	attack_cooldown_reduction = 46,			// percent reduced
	spell_cooldown_reduction = 47,			// percent reduced
	critical_hit_chance = 48,
	critical_hit_damage = 49,
	
	more_critical_hit_chance = 50,
	more_critical_hit_damage = 51,
	leech_effectiveness = 52,
	enhanced_damage = 53,
	
	accuracy = 54,
	recovery_rate = 55,
	stagger = 56,
	absorption_duration = 57,
	
	
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



global.stat_maps = ds_map_create();

global.stat_maps[? stats.life] = ds_map_create();			
ds_map_add(global.stat_maps[? stats.life], "arg1", 0);
ds_map_add(global.stat_maps[? stats.life], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.life], "stat", stats.life);

global.stat_maps[? stats.mana] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.mana], "arg1", 0);
ds_map_add(global.stat_maps[? stats.mana], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.mana], "stat", stats.mana);

global.stat_maps[? stats.stamina] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.stamina], "arg1", 0);
ds_map_add(global.stat_maps[? stats.stamina], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.stamina], "stat", stats.stamina);

global.stat_maps[? stats.life_percent] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.life_percent], "arg1", 0);
ds_map_add(global.stat_maps[? stats.life_percent], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.life_percent], "stat", stats.life_percent);

global.stat_maps[? stats.mana_percent] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.mana_percent], "arg1", 0);
ds_map_add(global.stat_maps[? stats.mana_percent], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.mana_percent], "stat", stats.mana_percent);

global.stat_maps[? stats.stamina_percent] = ds_map_create();			
ds_map_add(global.stat_maps[? stats.stamina_percent], "arg1", 0);
ds_map_add(global.stat_maps[? stats.stamina_percent], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.stamina_percent], "stat", stats.stamina_percent);

global.stat_maps[? stats.life_regen] = ds_map_create();			
ds_map_add(global.stat_maps[? stats.life_regen], "arg1", 0);
ds_map_add(global.stat_maps[? stats.life_regen], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.life_regen], "stat", stats.life_regen);

global.stat_maps[? stats.mana_regen] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.mana_regen], "arg1", 0);
ds_map_add(global.stat_maps[? stats.mana_regen], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.mana_regen], "stat", stats.mana_regen);

global.stat_maps[? stats.stamina_regen] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.stamina_regen], "arg1", 0);
ds_map_add(global.stat_maps[? stats.stamina_regen], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.stamina_regen], "stat", stats.stamina_regen);

global.stat_maps[? stats.life_regen_speed] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.life_regen_speed], "arg1", 0);
ds_map_add(global.stat_maps[? stats.life_regen_speed], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.life_regen_speed], "stat", stats.life_regen_speed);

//10
global.stat_maps[? stats.mana_regen_speed] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.mana_regen_speed], "arg1", 0);
ds_map_add(global.stat_maps[? stats.mana_regen_speed], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.mana_regen_speed], "stat", stats.mana_regen_speed);

global.stat_maps[? stats.stamina_regen_speed] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.stamina_regen_speed], "arg1", 0);
ds_map_add(global.stat_maps[? stats.stamina_regen_speed], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.stamina_regen_speed], "stat", stats.stamina_regen_speed);

global.stat_maps[? stats.life_steal] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.life_steal], "arg1", 0);
ds_map_add(global.stat_maps[? stats.life_steal], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.life_steal], "stat", stats.life_steal);

global.stat_maps[? stats.mana_steal] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.mana_steal], "arg1", 0);
ds_map_add(global.stat_maps[? stats.mana_steal], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.mana_steal], "stat", stats.mana_steal);

global.stat_maps[? stats.life_per_hit] = ds_map_create();			
ds_map_add(global.stat_maps[? stats.life_per_hit], "arg1", 0);
ds_map_add(global.stat_maps[? stats.life_per_hit], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.life_per_hit], "stat", stats.life_per_hit);

global.stat_maps[? stats.mana_per_hit] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.mana_per_hit], "arg1", 0);
ds_map_add(global.stat_maps[? stats.mana_per_hit], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.mana_per_hit], "stat", stats.mana_per_hit);

global.stat_maps[? stats.life_on_kill] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.life_on_kill], "arg1", 0);
ds_map_add(global.stat_maps[? stats.life_on_kill], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.life_on_kill], "stat", stats.life_on_kill);

global.stat_maps[? stats.mana_on_kill] = ds_map_create();				
ds_map_add(global.stat_maps[? stats.mana_on_kill], "arg1", 0);
ds_map_add(global.stat_maps[? stats.mana_on_kill], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.mana_on_kill], "stat", stats.mana_on_kill);

global.stat_maps[? stats.stamina_on_kill] = ds_map_create();			
ds_map_add(global.stat_maps[? stats.stamina_on_kill], "arg1", 0);
ds_map_add(global.stat_maps[? stats.stamina_on_kill], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.stamina_on_kill], "stat", stats.stamina_on_kill);


global.stat_maps[? stats.all_skills] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.all_skills], "arg1", 0); // amount
ds_map_add(global.stat_maps[? stats.all_skills], "num_arguments", 1);
ds_map_add(global.stat_maps[? stats.all_skills], "stat", stats.all_skills);

global.stat_maps[? stats.class_skills] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.class_skills], "arg1", 0); // amount
ds_map_add(global.stat_maps[? stats.class_skills], "arg2", 0); // class
ds_map_add(global.stat_maps[? stats.class_skills], "num_arguments", 2); 
ds_map_add(global.stat_maps[? stats.class_skills], "stat", stats.class_skills);

global.stat_maps[? stats.class_skill_tree] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.class_skill_tree], "arg1", 0); // amount
ds_map_add(global.stat_maps[? stats.class_skill_tree], "arg2", 0); // skill tree
ds_map_add(global.stat_maps[? stats.class_skill_tree], "num_arguments", 2); 
ds_map_add(global.stat_maps[? stats.class_skill_tree], "stat", stats.class_skill_tree);

global.stat_maps[? stats.specific_skill] = ds_map_create();
ds_map_add(global.stat_maps[? stats.specific_skill], "arg1", 0); // amount
ds_map_add(global.stat_maps[? stats.specific_skill], "arg2", 0); // skill
ds_map_add(global.stat_maps[? stats.specific_skill], "num_arguments", 2); 
ds_map_add(global.stat_maps[? stats.specific_skill], "stat", stats.specific_skill);


global.stat_maps[? stats.damage_to_attacks] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.damage_to_attacks], "arg1", 0);
ds_map_add(global.stat_maps[? stats.damage_to_attacks], "arg2", 0);
ds_map_add(global.stat_maps[? stats.damage_to_attacks], "num_arguments", 2); 
ds_map_add(global.stat_maps[? stats.damage_to_attacks], "stat", stats.damage_to_attacks);

global.stat_maps[? stats.damage_to_spells] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.damage_to_spells], "arg1", 0);
ds_map_add(global.stat_maps[? stats.damage_to_spells], "arg2", 0);
ds_map_add(global.stat_maps[? stats.damage_to_spells], "num_arguments", 2); 
ds_map_add(global.stat_maps[? stats.damage_to_spells], "stat", stats.damage_to_spells);

//25
global.stat_maps[? stats.immunity_to_status_effect] = ds_map_create();
ds_map_add(global.stat_maps[? stats.immunity_to_status_effect], "arg1", noone); // status effect
ds_map_add(global.stat_maps[? stats.immunity_to_status_effect], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.immunity_to_status_effect], "stat", stats.immunity_to_status_effect);

global.stat_maps[? stats.reduced_duration_to_status_effect] = ds_map_create();
ds_map_add(global.stat_maps[? stats.reduced_duration_to_status_effect], "arg1", 0); // percent reduction
ds_map_add(global.stat_maps[? stats.reduced_duration_to_status_effect], "arg2", noone); // status effect
ds_map_add(global.stat_maps[? stats.reduced_duration_to_status_effect], "num_arguments", 2); 
ds_map_add(global.stat_maps[? stats.reduced_duration_to_status_effect], "stat", stats.reduced_duration_to_status_effect);


global.stat_maps[? stats.strength] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.strength], "arg1", 0);
ds_map_add(global.stat_maps[? stats.strength], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.strength], "stat", stats.strength);

global.stat_maps[? stats.dexterity] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.dexterity], "arg1", 0);
ds_map_add(global.stat_maps[? stats.dexterity], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.dexterity], "stat", stats.dexterity);

global.stat_maps[? stats.constitution] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.constitution], "arg1", 0);
ds_map_add(global.stat_maps[? stats.constitution], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.constitution], "stat", stats.constitution);

//30
global.stat_maps[? stats.intelligence] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.intelligence], "arg1", 0);
ds_map_add(global.stat_maps[? stats.intelligence], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.intelligence], "stat", stats.intelligence);

global.stat_maps[? stats.all_attributes] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.all_attributes], "arg1", 0);
ds_map_add(global.stat_maps[? stats.all_attributes], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.all_attributes], "stat", stats.all_attributes);


global.stat_maps[? stats.cast_skill_when_struck] = ds_map_create();
ds_map_add(global.stat_maps[? stats.cast_skill_when_struck], "arg1", 0); // chance
ds_map_add(global.stat_maps[? stats.cast_skill_when_struck], "arg2", 0); // skill level
ds_map_add(global.stat_maps[? stats.cast_skill_when_struck], "arg3", 0); // skill
ds_map_add(global.stat_maps[? stats.cast_skill_when_struck], "num_arguments", 3); 
ds_map_add(global.stat_maps[? stats.cast_skill_when_struck], "stat", stats.cast_skill_when_struck);

global.stat_maps[? stats.cast_skill_on_striking] = ds_map_create();
ds_map_add(global.stat_maps[? stats.cast_skill_on_striking], "arg1", 0); // chance
ds_map_add(global.stat_maps[? stats.cast_skill_on_striking], "arg2", 0); // skill level
ds_map_add(global.stat_maps[? stats.cast_skill_on_striking], "arg3", 0); // skill
ds_map_add(global.stat_maps[? stats.cast_skill_on_striking], "num_arguments", 3); 
ds_map_add(global.stat_maps[? stats.cast_skill_on_striking], "stat", stats.cast_skill_on_striking);

global.stat_maps[? stats.armor_deflection] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.armor_deflection], "arg1", 0);
ds_map_add(global.stat_maps[? stats.armor_deflection], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.armor_deflection], "stat", stats.armor_deflection);

global.stat_maps[? stats.armor_absorption] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.armor_absorption], "arg1", 0);
ds_map_add(global.stat_maps[? stats.armor_absorption], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.armor_absorption], "stat", stats.armor_absorption);

global.stat_maps[? stats.enhanced_deflection] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.enhanced_deflection], "arg1", 0);
ds_map_add(global.stat_maps[? stats.enhanced_deflection], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.enhanced_deflection], "stat", stats.enhanced_deflection);

global.stat_maps[? stats.enhanced_absorption] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.enhanced_absorption], "arg1", 0);
ds_map_add(global.stat_maps[? stats.enhanced_absorption], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.enhanced_absorption], "stat", stats.enhanced_absorption);

global.stat_maps[? stats.shield_recovery_time] = ds_map_create();		
ds_map_add(global.stat_maps[? stats.shield_recovery_time], "arg1", 0);
ds_map_add(global.stat_maps[? stats.shield_recovery_time], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.shield_recovery_time], "stat", stats.shield_recovery_time);

global.stat_maps[? stats.shield_chance_to_block] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.shield_chance_to_block], "arg1", 0);
ds_map_add(global.stat_maps[? stats.shield_chance_to_block], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.shield_chance_to_block], "stat", stats.shield_chance_to_block);

//40
global.stat_maps[? stats.parry_damage_blocked] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.parry_damage_blocked], "arg1", 0);
ds_map_add(global.stat_maps[? stats.parry_damage_blocked], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.parry_damage_blocked], "stat", stats.parry_damage_blocked);

global.stat_maps[? stats.parry_effectiveness] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.parry_effectiveness], "arg1", 0);
ds_map_add(global.stat_maps[? stats.parry_effectiveness], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.parry_effectiveness], "stat", stats.parry_effectiveness);

global.stat_maps[? stats.parry_chance_to_block] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.parry_chance_to_block], "arg1", 0);
ds_map_add(global.stat_maps[? stats.parry_chance_to_block], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.parry_chance_to_block], "stat", stats.parry_chance_to_block);

global.stat_maps[? stats.dodge] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.dodge], "arg1", 0);
ds_map_add(global.stat_maps[? stats.dodge], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.dodge], "stat", stats.dodge);


global.stat_maps[? stats.movement_speed] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.movement_speed], "arg1", 0);
ds_map_add(global.stat_maps[? stats.movement_speed], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.movement_speed], "stat", stats.movement_speed);

global.stat_maps[? stats.magic_find] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.magic_find], "arg1", 0);
ds_map_add(global.stat_maps[? stats.magic_find], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.magic_find], "stat", stats.magic_find);

global.stat_maps[? stats.attack_cooldown_reduction] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.attack_cooldown_reduction], "arg1", 0);
ds_map_add(global.stat_maps[? stats.attack_cooldown_reduction], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.attack_cooldown_reduction], "stat", stats.attack_cooldown_reduction);

global.stat_maps[? stats.spell_cooldown_reduction] = ds_map_create();	
ds_map_add(global.stat_maps[? stats.spell_cooldown_reduction], "arg1", 0);
ds_map_add(global.stat_maps[? stats.spell_cooldown_reduction], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.spell_cooldown_reduction], "stat", stats.spell_cooldown_reduction);

global.stat_maps[? stats.critical_hit_chance] = ds_map_create();
ds_map_add(global.stat_maps[? stats.critical_hit_chance], "arg1", 0);
ds_map_add(global.stat_maps[? stats.critical_hit_chance], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.critical_hit_chance], "stat", stats.critical_hit_chance);

global.stat_maps[? stats.critical_hit_damage] = ds_map_create();
ds_map_add(global.stat_maps[? stats.critical_hit_damage], "arg1", 0);
ds_map_add(global.stat_maps[? stats.critical_hit_damage], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.critical_hit_damage], "stat", stats.critical_hit_damage);

global.stat_maps[? stats.more_critical_hit_chance] = ds_map_create();
ds_map_add(global.stat_maps[? stats.more_critical_hit_chance], "arg1", 0);
ds_map_add(global.stat_maps[? stats.more_critical_hit_chance], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.more_critical_hit_chance], "stat", stats.more_critical_hit_chance);

global.stat_maps[? stats.more_critical_hit_damage] = ds_map_create();
ds_map_add(global.stat_maps[? stats.more_critical_hit_damage], "arg1", 0);
ds_map_add(global.stat_maps[? stats.more_critical_hit_damage], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.more_critical_hit_damage], "stat", stats.more_critical_hit_damage);

global.stat_maps[? stats.leech_effectiveness] = ds_map_create();
ds_map_add(global.stat_maps[? stats.leech_effectiveness], "arg1", 0);
ds_map_add(global.stat_maps[? stats.leech_effectiveness], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.leech_effectiveness], "stat", stats.leech_effectiveness);

global.stat_maps[? stats.enhanced_damage] = ds_map_create();
ds_map_add(global.stat_maps[? stats.enhanced_damage], "arg1", 0);
ds_map_add(global.stat_maps[? stats.enhanced_damage], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.enhanced_damage], "stat", stats.enhanced_damage);



global.stat_maps[? stats.accuracy] = ds_map_create();
ds_map_add(global.stat_maps[? stats.accuracy], "arg1", 0);
ds_map_add(global.stat_maps[? stats.accuracy], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.accuracy], "stat", stats.accuracy);

global.stat_maps[? stats.recovery_rate] = ds_map_create();
ds_map_add(global.stat_maps[? stats.recovery_rate], "arg1", 0);
ds_map_add(global.stat_maps[? stats.recovery_rate], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.recovery_rate], "stat", stats.recovery_rate);

global.stat_maps[? stats.stagger] = ds_map_create();
ds_map_add(global.stat_maps[? stats.stagger], "arg1", 0);
ds_map_add(global.stat_maps[? stats.stagger], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.stagger], "stat", stats.stagger);

global.stat_maps[? stats.absorption_duration] = ds_map_create();
ds_map_add(global.stat_maps[? stats.absorption_duration], "arg1", 0);
ds_map_add(global.stat_maps[? stats.absorption_duration], "num_arguments", 1); 
ds_map_add(global.stat_maps[? stats.absorption_duration], "stat", stats.absorption_duration);

//	STATS TO ADD:
//	recovery_rate			(speeds up animation speed of 'hurt_anim')
//	stagger_amount			(slows down animation speed of 'hurt_anim' for enemies)
//	accuracy				(like attack rating, determines chance to hit 
//	absorption duration		(increases length of time that absorbed damage is distributed over)


/*
global.stat_maps[? stats.mobility_skill_speed] = ds_map_create();		
global.stat_maps[? stats.mobility_skill_length] = ds_map_create();		
global.stat_maps[? stats.mobility_skill_cooldown] = ds_map_create();	
global.stat_maps[? stats.attack_skill_duration] = ds_map_create();	
global.stat_maps[? stats.attack_skill_aoe] = ds_map_create();	
global.stat_maps[? stats.attack_skill_projectiles] = ds_map_create();	
global.stat_maps[? stats.spell_skill_duration] = ds_map_create();	
global.stat_maps[? stats.spell_skill_aoe] = ds_map_create();	
global.stat_maps[? stats.spell_skill_projectiles] = ds_map_create();	
global.stat_maps[? stats.skill_duration] = ds_map_create();	
global.stat_maps[? stats.skill_aoe] = ds_map_create();	
global.stat_maps[? stats.skill_projectiles] = ds_map_create();	
global.stat_maps[? stats.aura_aoe] = ds_map_create();	
global.stat_maps[? stats.aura_potency] = ds_map_create();	
*/









global.stat_to_string = ds_map_create();

global.stat_to_string[? stats.life] = "+$ to Life"; 
global.stat_to_string[? stats.mana] = "+$ to Mana";
global.stat_to_string[? stats.stamina] = "+$ to Stamina";
global.stat_to_string[? stats.life_percent] = "$% Increased Life";
global.stat_to_string[? stats.mana_percent] = "$% Increased Mana";
global.stat_to_string[? stats.stamina_percent] = "$% Increased Stamina";
global.stat_to_string[? stats.life_regen] = "+$ Life Regenerated per Second";
global.stat_to_string[? stats.mana_regen] = "+$ Mana Regenerated per Second";
global.stat_to_string[? stats.stamina_regen] = "+$ Stamina Regenerated Per Second";
global.stat_to_string[? stats.life_regen_speed] = "$% Increased Life Regeneration";
global.stat_to_string[? stats.mana_regen_speed] = "$% Increased Mana Regeneration";
global.stat_to_string[? stats.stamina_regen_speed] = "$% Increased Stamina Regeneration";
global.stat_to_string[? stats.life_steal] = "+$% Life Steal";
global.stat_to_string[? stats.mana_steal] = "+$% Mana Steal";
global.stat_to_string[? stats.life_per_hit] = "+$ Life Stolen per Hit";
global.stat_to_string[? stats.mana_per_hit] = "+$ Mana Stolen per Hit";
global.stat_to_string[? stats.life_on_kill] = "+$% Life Gained on Kill";
global.stat_to_string[? stats.mana_on_kill] = "+$% Mana Gained on Kill";
global.stat_to_string[? stats.stamina_on_kill] = "+$% Stamina Gained on Kill";



global.stat_to_string[? stats.all_skills] = "+$ to All Skills";
global.stat_to_string[? stats.class_skills] = "+$ to $ Skills";	
global.stat_to_string[? stats.class_skill_tree] = "+$ to $ Skill Tree";			
global.stat_to_string[? stats.specific_skill] = "+$ to $ Skill";

global.stat_to_string[? stats.damage_to_attacks] = "+$ to $ Damage to Attacks";
global.stat_to_string[? stats.damage_to_spells] = "+$ to $ Damage to Spells";

global.stat_to_string[? stats.immunity_to_status_effect] = "Immunity to $";
global.stat_to_string[? stats.reduced_duration_to_status_effect] = "$% Reduced Duration of $";

global.stat_to_string[? stats.strength] = "+$ to Strength";
global.stat_to_string[? stats.dexterity] = "+$ to Dexterity";
global.stat_to_string[? stats.constitution] = "+$ to Constitution";
global.stat_to_string[? stats.intelligence] = "+$ to Intelligence";
global.stat_to_string[? stats.all_attributes] = "+$ to All Attributes";


global.stat_to_string[? stats.cast_skill_when_struck] = "$% Chance to Cast Level $ $ when Struck";		
global.stat_to_string[? stats.cast_skill_on_striking] = "$% Chance to Cast Level $ $ on Striking";

global.stat_to_string[? stats.armor_deflection] = "+$ to Deflection Rating";
global.stat_to_string[? stats.armor_absorption] = "+$ to Absorption Rating";
global.stat_to_string[? stats.enhanced_deflection] = "$% Increased Armor Deflection";
global.stat_to_string[? stats.enhanced_absorption] = "$% Increased Armor Absorption";
global.stat_to_string[? stats.shield_recovery_time] = "$% Reduced Shield Recovery Time";
global.stat_to_string[? stats.shield_chance_to_block] = "+$% to Shield Block Chance";
global.stat_to_string[? stats.parry_damage_blocked] = "+$ Damage Blocked by Parry";
global.stat_to_string[? stats.parry_effectiveness] = "$% Increased Damage Blocked by Parry";
global.stat_to_string[? stats.parry_chance_to_block] = "+$% to Parry Block Chance";
global.stat_to_string[? stats.dodge] = "+$% to Dodge Chance";


global.stat_to_string[? stats.movement_speed] = "$% Increased Movement Speed";
global.stat_to_string[? stats.magic_find] = "+$% to Magic Find";
global.stat_to_string[? stats.attack_cooldown_reduction] = "$% Reduced Attack Cooldown";
global.stat_to_string[? stats.spell_cooldown_reduction] = "$% Reduced Spell Cooldown";

global.stat_to_string[? stats.critical_hit_chance] = "$% Increased Critical Hit Chance";
global.stat_to_string[? stats.critical_hit_damage] = "$% Increased Critical Hit Damage";
global.stat_to_string[? stats.more_critical_hit_chance] = "$% More Critical Hit Chance";
global.stat_to_string[? stats.more_critical_hit_damage] = "$% More Critical Hit Damage";
global.stat_to_string[? stats.leech_effectiveness] = "$% Increased Overall Leech Effectiveness";
global.stat_to_string[? stats.enhanced_damage] = "$% Enhanced Weapon Damage";

global.stat_to_string[? stats.accuracy] = "+$ to Accuracy Rating";
global.stat_to_string[? stats.recovery_rate] = "$% Faster Hit-Recovery";
global.stat_to_string[? stats.stagger] = "$% Increased Stagger On Hit";
global.stat_to_string[? stats.absorption_duration] = "$% Increased Absorption Duration";

/*
global.stat_to_string[? stats.mobility_skill_speed] = ds_map_create();		
global.stat_to_string[? stats.mobility_skill_length] = ds_map_create();		
global.stat_to_string[? stats.mobility_skill_cooldown] = ds_map_create();	
global.stat_to_string[? stats.attack_skill_duration] = ds_map_create();	
global.stat_to_string[? stats.attack_skill_aoe] = ds_map_create();	
global.stat_to_string[? stats.attack_skill_projectiles] = ds_map_create();	
global.stat_to_string[? stats.spell_skill_duration] = ds_map_create();	
global.stat_to_string[? stats.spell_skill_aoe] = ds_map_create();	
global.stat_to_string[? stats.spell_skill_projectiles] = ds_map_create();	
global.stat_to_string[? stats.skill_duration] = ds_map_create();	
global.stat_to_string[? stats.skill_aoe] = ds_map_create();	
global.stat_to_string[? stats.skill_projectiles] = ds_map_create();	
global.stat_to_string[? stats.aura_aoe] = ds_map_create();	
global.stat_to_string[? stats.aura_potency] = ds_map_create();	
*/

global.stat_list = ds_list_create();

ds_list_add(global.stat_list, stats.life);
ds_list_add(global.stat_list, stats.mana);
ds_list_add(global.stat_list, stats.stamina);
ds_list_add(global.stat_list, stats.life_percent);
ds_list_add(global.stat_list, stats.mana_percent);
ds_list_add(global.stat_list, stats.stamina_percent);
ds_list_add(global.stat_list, stats.life_regen);
ds_list_add(global.stat_list, stats.mana_regen);
ds_list_add(global.stat_list, stats.stamina_regen);
ds_list_add(global.stat_list, stats.life_regen_speed);
	
ds_list_add(global.stat_list, stats.mana_regen_speed);
ds_list_add(global.stat_list, stats.stamina_regen_speed);
ds_list_add(global.stat_list, stats.life_steal);
ds_list_add(global.stat_list, stats.mana_steal);
ds_list_add(global.stat_list, stats.life_per_hit);
ds_list_add(global.stat_list, stats.mana_per_hit);
ds_list_add(global.stat_list, stats.life_on_kill);
ds_list_add(global.stat_list, stats.mana_on_kill);
ds_list_add(global.stat_list, stats.stamina_on_kill);
ds_list_add(global.stat_list, stats.all_skills);
	
ds_list_add(global.stat_list, stats.class_skills);
ds_list_add(global.stat_list, stats.class_skill_tree);
ds_list_add(global.stat_list, stats.specific_skill);
ds_list_add(global.stat_list, stats.damage_to_attacks);
ds_list_add(global.stat_list, stats.damage_to_spells);
ds_list_add(global.stat_list, stats.immunity_to_status_effect);
ds_list_add(global.stat_list, stats.reduced_duration_to_status_effect);
ds_list_add(global.stat_list, stats.strength);
ds_list_add(global.stat_list, stats.dexterity);
ds_list_add(global.stat_list, stats.constitution);
	
ds_list_add(global.stat_list, stats.intelligence);
ds_list_add(global.stat_list, stats.all_attributes);
ds_list_add(global.stat_list, stats.cast_skill_when_struck);
ds_list_add(global.stat_list, stats.cast_skill_on_striking);
ds_list_add(global.stat_list, stats.armor_deflection);
ds_list_add(global.stat_list, stats.armor_absorption);
ds_list_add(global.stat_list, stats.enhanced_deflection);
ds_list_add(global.stat_list, stats.enhanced_absorption);
ds_list_add(global.stat_list, stats.shield_recovery_time);
ds_list_add(global.stat_list, stats.shield_chance_to_block);
	
ds_list_add(global.stat_list, stats.parry_damage_blocked);
ds_list_add(global.stat_list, stats.parry_effectiveness);
ds_list_add(global.stat_list, stats.parry_chance_to_block);
ds_list_add(global.stat_list, stats.dodge);
ds_list_add(global.stat_list, stats.movement_speed);

ds_list_add(global.stat_list, stats.magic_find);
ds_list_add(global.stat_list, stats.attack_cooldown_reduction);
ds_list_add(global.stat_list, stats.spell_cooldown_reduction);

ds_list_add(global.stat_list, stats.critical_hit_chance);
ds_list_add(global.stat_list, stats.critical_hit_damage);
ds_list_add(global.stat_list, stats.more_critical_hit_chance);
ds_list_add(global.stat_list, stats.more_critical_hit_damage);
ds_list_add(global.stat_list, stats.leech_effectiveness);
ds_list_add(global.stat_list, stats.enhanced_damage);

ds_list_add(global.stat_list, stats.accuracy);
ds_list_add(global.stat_list, stats.recovery_rate);
ds_list_add(global.stat_list, stats.stagger);
ds_list_add(global.stat_list, stats.absorption_duration);


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
*/