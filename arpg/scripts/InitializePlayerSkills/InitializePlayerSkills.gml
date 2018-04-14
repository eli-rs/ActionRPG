
global.player_skills = ds_list_create();

//================== PLAYER SKILLS
// SKILL: MULTI-SHOT
player_skill_multishot = ds_map_create();
player_skill_multishot[? "level"] = 15;
player_skill_multishot[? "sprite_index"] = spr_icons_skills3_small;
player_skill_multishot[? "image_index"] = 40;
player_skill_multishot[? "name"] = "Multi-Shot";
player_skill_multishot[? "script"] = MultiShot;
player_skill_multishot[? "cooldown"] = 3; //cooldown time in seconds
player_skill_multishot[? "timer"] = 0;
player_skill_multishot[? "projectile"] = global.projectiles[| 0];
global.player_skills[| 0] = player_skill_multishot;

// SKILL: ARROW NOVA
player_skill_arrownova = ds_map_create();
player_skill_arrownova[? "level"] = 3;
player_skill_arrownova[? "sprite_index"] = spr_icons_skills3_small;
player_skill_arrownova[? "image_index"] = 41;
player_skill_arrownova[? "name"] = "Arrow Nova";
player_skill_arrownova[? "script"] = ArrowNova;
player_skill_arrownova[? "cooldown"] = 6;
player_skill_arrownova[? "timer"] = 0;
player_skill_arrownova[? "projectile"] = global.projectiles[| 0];
var arrownova_dmg;
arrownova_dmg[0] = 14;
arrownova_dmg[1] = 21;
player_skill_arrownova[? "damage_range"] = arrownova_dmg;
global.player_skills[| 1] = player_skill_arrownova;

// SKILL: WHIRLWIND
player_skill_whirlwind = ds_map_create();
player_skill_whirlwind[? "level"] = 1;
player_skill_whirlwind[? "sprite_index"] = spr_icons_skills3_small;
player_skill_whirlwind[? "image_index"] = 46;
player_skill_whirlwind[? "name"] = "Whirlwind";
player_skill_whirlwind[? "script"] = Whirlwind;
player_skill_whirlwind[? "cooldown"] = 14;
player_skill_whirlwind[? "timer"] = 0;
player_skill_whirlwind[? "duration"] = 6 * game_get_speed(gamespeed_fps); // 6 seconds
var whirlwind_dmg;
whirlwind_dmg[0] = 14;
whirlwind_dmg[1] = 21;
player_skill_whirlwind[? "damage_range"] = whirlwind_dmg;
player_skill_whirlwind[? "crit_chance"] = 0.05;
player_skill_whirlwind[? "crit_mult"] = 1.5;
player_skill_whirlwind[? "tick_rate"] = 15;
global.player_skills[| 2] = player_skill_whirlwind;