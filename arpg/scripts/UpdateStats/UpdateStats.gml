
// HERE IS WHERE I NEED TO ACTUALLY TAKE THE VALUES STORED IN OBJ_CHARACTER_SHEET
//	AND TRANSLATE THEM INTO THE VALUES THAT WILL BE DRAWN ON EVERY TIME THEY ARE NEEDED
// 
// HERE ARE EVENTS THAT WILL CALL THE STATS:
//		* PLAYER ATTACKS (PASSES STATS INTO HITBOX OBJECT, ALSO CAST ON STRIKING)
//		* PLAYER USES SKILL (PASSES STATS, +SKILLS,ETC INTO SKILL'S SCRIPT, AND IN TURN INTO WHATEVER OBJ)
//		* PLAYER'S ATTACK/SKILL HITS ENEMY (LIFE STEAL, ETC)
//		* PLAYER SUCCESSFULLY KILLS ENEMY (LIFE ON KILL, ETC)
//		* ENEMY IS KILLED (NEEDS TO ACCESS MAGIC FIND SKILL TO DETERMINE APPROPRIATE AMOUNT OF LOOT)
//		* ENEMY TRIES TO HIT PLAYER (IE COLLISION BETWEEN PLAYER AND ENEMY ATTACK OBJ)
//			(STATS USED, DODGE, ARMOR, DEFLECT, ABSORB, ETC)
//		* ENEMY SUCCESSFULLY HITS PLAYAER (CAST WHEN STRUCK)
//		* ENEMY TRIES TO INFLICT STATUS ON PLAYER (IMMUNE, OR REDUCED DUR)
//		* DRAW GUI CALLS, MAKING USE OF PLAYER'S FINAL HEALTH VAL, MANA, ETC
//		* DRAW GUI CHARACTER SHEET, WHEN OPENENED WILL NEED TO DISPLAY VARIOUS STATS
//		* PLAYER STEP EVENT CALLS FOR LIFE/MANA/STAM REGENERATION, MOVEMENT SPEED, ATTACK/SPELL/SKILL COOLDOWNS
//		* DRAW CALLS TO PLAYER SKILLS, SHOULD SHOW SKILL LEVELS THAT INCLUDE THE STATS FOR +ALL / +SPECIFIC SKILLS


var p = obj_player;
var stat_bible = obj_character_sheet.stat_bible;
var flat, flat_arg, percent, percent_arg;

var all_attr = stat_bible[? stats.all_attributes];
var all_arg = all_attr[? "arg1"];

flat = stat_bible[? stats.strength];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.strength] = p.player_strength + flat_arg + all_arg;

flat = stat_bible[? stats.dexterity];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.dexterity] = p.player_dexterity + flat_arg + all_arg;

flat = stat_bible[? stats.constitution];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.constitution] = p.player_constitution + flat_arg + all_arg;

flat = stat_bible[? stats.intelligence];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.intelligence] = p.player_intelligence + flat_arg + all_arg;


//		LIFE
flat = stat_bible[? stats.life];				
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.life_percent];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.life] = round( (p.player_health_base + flat_arg + 
	((global.player_stats[? derived_stats.constitution]) * 4)) 
	* (1 + (percent_arg / 100)) );
	
//		MANA
flat = stat_bible[? stats.mana];
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.mana_percent];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.mana] = round( (p.player_health_base + flat_arg +  	
	((global.player_stats[? derived_stats.intelligence]) * 5)) 
	* (1 + (percent_arg / 100)) );
	
//		STAMINA
flat = stat_bible[? stats.stamina];
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.stamina_percent];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.stamina] = round( (p.player_health_base + flat_arg + 	
	((global.player_stats[? derived_stats.constitution]) * 2)) 
	* (1 + (percent_arg / 100)) );
	
//		LIFE REGEN
flat = stat_bible[? stats.life_regen];
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.life_regen_speed];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.life_regen] = round( (flat_arg) * (1 + (percent_arg / 100)) );
//		MANA REGEN
flat = stat_bible[? stats.mana_regen];
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.mana_regen_speed];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.mana_regen] = round( (flat_arg + round(global.player_stats[? derived_stats.intelligence] / 5)) * (1 + (percent_arg / 100)) );
//		STAMINA REGEN
flat = stat_bible[? stats.stamina_regen];
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.stamina_regen_speed];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.stamina_regen] = round( (flat_arg) * (1 + (percent_arg / 100)) );


percent = stat_bible[? stats.leech_effectiveness];
percent_arg = percent[? "arg1"];
//		LIFE STEAL
flat = stat_bible[? stats.life_steal];
flat_arg = flat[? "arg1"];

global.player_stats[? derived_stats.life_steal] = flat_arg * (1 + (percent_arg / 100));
//		MANA STEAL
flat = stat_bible[? stats.mana_steal];
flat_arg = flat[? "arg1"];


global.player_stats[? derived_stats.mana_steal] = flat_arg * (1 + (percent_arg / 100));
//		LIFE PER HIT
flat = stat_bible[? stats.life_per_hit];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.life_per_hit] = flat_arg;
//		MANA PER HIT
flat = stat_bible[? stats.mana_per_hit];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.mana_per_hit] = 0;
//		LIFE ON KILL
flat = stat_bible[? stats.life_on_kill];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.life_on_kill] = flat_arg;
//		MANA ON KILL
flat = stat_bible[? stats.mana_on_kill];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.mana_on_kill] = flat_arg;
//		STAMINA ON KILL
flat = stat_bible[? stats.stamina_on_kill];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.stamina_on_kill] = flat_arg;

// CALCULATE DAMAGE, USING WEAPON DAMAGE (AND OFFHAND DMG IF DUAL WIELD), ENHANCED DAMAGE, AND DAMAGE-TO-ATTACKS/SPELLS
var weapon_damage_min = 0;
var weapon_damage_max = 0;
var attack_damage;
var spell_damage;
var weapon = global.equipment[| equipment.weapon];
if (weapon[? "item_id"] != -1)
{
	var item = global.items[| weapon[? "item_id"]];
	var idmg = item[? "base_values"];
	weapon_damage_min += idmg[| 0];
	weapon_damage_max += idmg[| 1];
}

var offhand = global.equipment[| equipment.offhand];
if (offhand[? "item_id"] != -1) 
{
	var item = global.items[| offhand[? "item_id"]];
	if (item[? "item_type"] == "Weapon")
	{
		idmg = item[? "base_values"];
		weapon_damage_min += idmg[| 0];
		weapon_damage_max += idmg[| 1];
	}
}

percent = stat_bible[? stats.enhanced_damage];
percent_arg = percent[? "arg1"];
weapon_damage_min *= 1 + (percent_arg / 100);
weapon_damage_max *= 1 + (percent_arg / 100);
flat = stat_bible[? stats.damage_to_attacks];
attack_damage[0] = weapon_damage_min + flat[? "arg1"];
attack_damage[1] = weapon_damage_max + flat[? "arg2"];
//ATTACK DAMAGE
global.player_stats[? derived_stats.attack_damage] = attack_damage; 

flat = stat_bible[? stats.damage_to_spells];
spell_damage[0] = weapon_damage_min + flat[? "arg1"];
spell_damage[1] = weapon_damage_max + flat[? "arg2"];
// SPELL DAMAGE
global.player_stats[? derived_stats.spell_damage] = spell_damage;

// IMMUNITY TO STATUS EFFECTS
global.player_stats[? derived_stats.immunity_to_status_effect] = stat_bible[? stats.immunity_to_status_effect];
// REDUCED DURATION OF STATUS EFFECTS
global.player_stats[? derived_stats.reduced_duration_to_status_effect] = stat_bible[? stats.reduced_duration_to_status_effect];



// CAST SKILL WHEN STRUCK
global.player_stats[? derived_stats.cast_skill_when_struck] = stat_bible[? stats.cast_skill_when_struck];
// CAST SKILL ON STRIKING
global.player_stats[? derived_stats.cast_skill_on_striking] = stat_bible[? stats.cast_skill_on_striking];

// ARMOR DEFLECTION 
flat = stat_bible[? stats.armor_deflection]; 
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.enhanced_deflection];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.armor_deflection] = flat_arg * (1 + (percent_arg / 100));
// ARMOR ABSORPTION
flat = stat_bible[? stats.armor_absorption];
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.enhanced_absorption];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.armor_absorption] = flat_arg * (1 + (percent_arg / 100));


global.player_stats[? derived_stats.shield_recovery_time] = 0;
global.player_stats[? derived_stats.shield_chance_to_block] = 0;


global.player_stats[? derived_stats.parry_damage_blocked] = 0;
global.player_stats[? derived_stats.parry_chance_to_block] = 0;

flat = stat_bible[? stats.dodge];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.dodge] = flat_arg;

flat = stat_bible[? stats.movement_speed];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.movement_speed] = flat_arg;

flat = stat_bible[? stats.magic_find];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.magic_find] = flat_arg;

global.player_stats[? derived_stats.attack_cooldown_reduction] = 0;
global.player_stats[? derived_stats.spell_cooldown_reduction] = 0;
// CRITICAL HIT CHANCE
flat = stat_bible[? stats.critical_hit_chance];
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.more_critical_hit_chance];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.critical_hit_chance] = (global.crit_chance_base * (1 + (flat_arg / 100))) * (1 + (percent_arg / 100));
// CRITICAL HIT DAMAGE
flat = stat_bible[? stats.critical_hit_damage];
flat_arg = flat[? "arg1"];
percent = stat_bible[? stats.more_critical_hit_damage];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.critical_hit_damage] = (global.crit_mult_base  + (flat_arg / 100)) * (1 + (percent_arg / 100));

flat = stat_bible[? stats.accuracy];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.accuracy] = flat_arg;
// HIT-RECOVERY
flat = stat_bible[? stats.recovery_rate];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.recovery_rate] = flat_arg;
// STAGGER LENGTH
flat = stat_bible[? stats.stagger];
flat_arg = flat[? "arg1"];
global.player_stats[? derived_stats.stagger] = flat_arg;

// ABSORPTION DURATION
percent = stat_bible[? stats.absorption_duration];
percent_arg = percent[? "arg1"];
global.player_stats[? derived_stats.absorption_duration] = round(obj_player.absorption_base_duration * (1 + (percent_arg / 100)));

// IF PLAYER'S ABSORPTION_DURATION STAT CHANGES, WE NEED TO RESIZE AND REDISTRIBUTE THE PLAYER'S ABSORBED_DAMAGE ARRAY
if (global.player_stats[? derived_stats.absorption_duration] > ds_list_size(obj_player.absorbed_damage) || 
	global.player_stats[? derived_stats.absorption_duration] < ds_list_size(obj_player.absorbed_damage))
{
	var current_duration = ds_list_size(obj_player.absorbed_damage);
	var duration_diff = global.player_stats[? derived_stats.absorption_duration] - current_duration;
	
	if (duration_diff > 0)
	{
		for (var i = 0; i < duration_diff; i++)
		{
			ds_list_add(obj_player.absorbed_damage, 0);
		}
	}
	else if (duration_diff < 0)
	{
		duration_diff = abs(duration_diff);
		// first we figure out how much damage needs to be redistributed from shrinking the d.o.t. array
		var total_to_redistribute = 0;
		for (var i = ds_list_size(obj_player.absorbed_damage) - duration_diff; i < ds_list_size(obj_player.absorbed_damage); i++)
		{
			total_to_redistribute += ds_list_find_value(obj_player.absorbed_damage, i);
		}
		// then we shrink the d.o.t. array
		for (var i = 0; i < duration_diff; i++)
			ds_list_delete(obj_player.absorbed_damage, ds_list_size(obj_player.absorbed_damage) - 1);
		// then we redistribute the damage evenly over the remaining d.o.t. array
		var damage_to_distribute = total_to_redistribute / ds_list_size(obj_player.absorbed_damage);
		for (var i = 0; i < ds_list_size(obj_player.absorbed_damage); i++)
		{
			obj_player.absorbed_damage[| i] += damage_to_distribute;
		}
		
	}
}

//	STATS TO ADD:
//	recovery_rate			(speeds up animation speed of 'hurt_anim')
//	stagger_amount			(slows down animation speed of 'hurt_anim' for enemies)
//	accuracy				(like attack rating, determines chance to hit 
//	absorption duration		(increases length of time that absorbed damage is distributed over)