window_set_fullscreen(true);
//shader_set(shd_test);
global.inventory_open = false;
global.character_sheet_open = false;

global.in_game = true;
global.paused = false;
global.anything_open = false;

global.daytime = true;


enum status {
	frozen,
	slowed,
	staggered,
	stunned,
	blind,
	bleeding,
	poisoned,
}

global.status_effects = ds_list_create();

var stfx_frozen = ds_map_create();
stfx_frozen[? "status"] = status.frozen;
stfx_frozen[? "name"] = "Frozen";
stfx_frozen[? "duration"] = 3; // set to 0 and change programmatically
stfx_frozen[? "timer"] = stfx_frozen[? "duration"] * game_get_speed(gamespeed_fps);
global.status_effects[| status.frozen] = stfx_frozen;

var stfx_slowed = ds_map_create();
stfx_slowed[? "status"] = status.slowed;
stfx_slowed[? "name"] = "Slowed";
stfx_slowed[? "duration"] = 3; // set to 0 and change programmatically
stfx_slowed[? "timer"] = stfx_slowed[? "duration"] * game_get_speed(gamespeed_fps);
global.status_effects[| status.slowed] = stfx_slowed;

var stfx_staggered = ds_map_create();
stfx_staggered[? "status"] = status.staggered;
stfx_staggered[? "name"] = "Staggered";
stfx_staggered[? "duration"] = 3; // set to 0 and change programmatically
stfx_staggered[? "timer"] = stfx_staggered[? "duration"] * game_get_speed(gamespeed_fps);
global.status_effects[| status.staggered] = stfx_staggered;

var stfx_stunned = ds_map_create();
stfx_stunned[? "status"] = status.stunned;
stfx_stunned[? "name"] = "Stunned";
stfx_stunned[? "duration"] = 6; // set to 0 and change programmatically
stfx_stunned[? "timer"] = stfx_stunned[? "duration"] * game_get_speed(gamespeed_fps);
global.status_effects[| status.stunned] = stfx_stunned;
ds_map_destroy(stfx_stunned);

var stfx_blind = ds_map_create();
stfx_blind[? "status"] = status.blind;
stfx_blind[? "name"] = "Blind";
stfx_blind[? "duration"] = 3; // set to 0 and change programmatically
stfx_blind[? "timer"] = stfx_blind[? "duration"] * game_get_speed(gamespeed_fps);
global.status_effects[| status.blind] = stfx_blind;

var stfx_bleeding = ds_map_create();
stfx_bleeding[? "status"] = status.bleeding;
stfx_bleeding[? "name"] = "Bleeding";
stfx_bleeding[? "duration"] = 6; // set to 0 and change programmatically
stfx_bleeding[? "timer"] = stfx_bleeding[? "duration"] * game_get_speed(gamespeed_fps);
global.status_effects[| status.bleeding] = stfx_bleeding;

var stfx_poisoned = ds_map_create();
stfx_poisoned[? "status"] = status.poisoned;
stfx_poisoned[? "name"] = "Poisoned";
stfx_poisoned[? "duration"] = 6; // set to 0 and change programmatically
stfx_poisoned[? "timer"] = stfx_poisoned[? "duration"] * game_get_speed(gamespeed_fps);
global.status_effects[| status.poisoned] = stfx_poisoned;

enum anim {
	idle_left,
	idle_right,
	walk_left,
	walk_right,
	run_left,
	run_right,
	attack_left,
	attack_right,
	death_left,
	death_right,
	hurt_left,
	hurt_right,
}
global.animation_states = ds_map_create();
global.animation_states[? anim.idle_left] = "_idle_left";
global.animation_states[? anim.idle_right] = "_idle_right";
global.animation_states[? anim.run_left] = "_run_left";
global.animation_states[? anim.run_right] = "_run_right";
global.animation_states[? anim.walk_left] = "_walk_left";
global.animation_states[? anim.walk_right] = "_walk_right";
global.animation_states[? anim.attack_left] = "_attack_left";
global.animation_states[? anim.attack_right] = "_attack_right";
global.animation_states[? anim.death_left] = "_death_left";
global.animation_states[? anim.death_right] = "_death_right";
global.animation_states[? anim.hurt_left] = "_hurt_left";
global.animation_states[? anim.hurt_right] = "_hurt_right";

randomize();


draw_set_font(fnt_rogue);

camera_width = camera_get_view_width(view_camera[0]);
//camera_set_view_size(view_camera[0], 480, 360);

camera_height = camera_get_view_height(view_camera[0]);
display_set_gui_size(camera_width, camera_height);
global.view_width = camera_width;
global.view_height = camera_height; 

global.settings = ds_map_create();
global.settings[? "item_burst_particles"] = true;
global.settings[? "enemy_death_particles"] = true;
global.settings[? "item_aura_sprites"] = false;
global.settings[? "inventory_shortcut"] = ord("I");
global.settings[? "character_sheet_shortcut"] = ord("C");
global.settings[? "potion_shortcut"] = ord("E");

global.player_stats = ds_map_create();

InitializePlayerProjectiles();
InitializePlayerSkills();

col_health_loss = make_color_rgb(242, 121, 0);
col_health_loss_light = make_color_rgb(255, 152, 50);
col_health_loss_dark = make_color_rgb(153, 76, 0);

level_up = false;

//instance_create_depth(x, y, depth, obj_room_generator);

border_size = sprite_get_width(spr_inventory_border)
InitializeItemMods();
InitializePlayerStats();
ConstructInventory();
dragging_item = false;
original_slot = noone;
item_dragged = noone;
offset_x = 0;
offset_y = 0;


//get_expanded_slot = false;
item_expanded = false;
equipment_expanded = false;
currently_selected_slot = noone;
currently_selected_item = noone;
dragging_swapable = false;
dragging_from_equipment = false;

global.blood_sprites = ds_list_create();
global.blood_sprites[| 0] = spr_blood_1;
global.blood_sprites[| 1] = spr_blood_2;
global.blood_sprites[| 2] = spr_blood_3;
global.blood_sprites[| 3] = spr_blood_4;
global.blood_sprites[| 4] = spr_blood_5;
global.blood_sprites[| 5] = spr_blood_6;

health_gui_x = sprite_get_width(spr_gui_health_mana_portrait) / 2;
health_gui_y = global.view_height -  (sprite_get_height(spr_gui_health_mana_portrait) / 2);
health_gui_y -= 13;

skillbar_gui_x = 28;
skillbar_gui_y = health_gui_y + 7;

//the number of pixels in from health_gui location that we want portrait to start
var portrait_offset = 5; 

portrait_x = (health_gui_x 
	- (sprite_get_width(spr_gui_health_mana_portrait) / 2)) 
	+ portrait_offset;
portrait_y = (health_gui_y 
	- (sprite_get_height(spr_gui_health_mana_portrait) / 2))
	+ portrait_offset;
	
color_stamina = make_color_rgb(160, 85, 11);
color_stamina_dark = make_color_rgb(102, 54, 7);
color_stamina_light = make_color_rgb(196, 125, 58);

color_health = make_color_rgb(127, 25, 28);
color_health_dark = make_color_rgb(76, 22, 23);
color_health_light = make_color_rgb(127, 50, 53);

color_hover_text = make_color_rgb(51, 46, 35);
color_underline = make_color_rgb(178, 164, 124);
	//135 184 148 light
	//63 116 77 norm
	//36 54 41 dark
color_xp_light = make_color_rgb(135, 184, 148);
color_xp_normal = make_color_rgb(63, 116, 77);
color_xp_dark = make_color_rgb(36, 54, 41);

item_rarity_colors = ds_map_create();
item_rarity_colors[? item_rarity_costs.common] = c_gray; 
item_rarity_colors[? item_rarity_costs.uncommon] = make_color_rgb(127, 61, 25);
item_rarity_colors[? item_rarity_costs.rare] = make_color_rgb(30, 53, 76);
item_rarity_colors[? item_rarity_costs.unique] = make_color_rgb(109, 208, 227);
item_rarity_colors[? item_rarity_costs.set] = make_color_rgb(38, 127, 62);

/*
global.item_particle_queue = ds_queue_create();
item_particles_to_destroy = ds_list_create();
*/
global.emitters = ds_list_create();
global.systems = ds_list_create();
global.particles = ds_list_create();

enum particles {
	death_particles,
	item_particles_rare,
	potion_particles,
	potion_particles_light,
	dash_particles,
	life_steal_particles
}
global.fx_system_1 = part_system_create_layer("Layer_Objects", true);

global.fx_emitter_1 = part_emitter_create(global.fx_system_1);

//part_emitter_burst(global.fx_system_1, global.fx_emitter_1, global.particle_1, 60);
//part_emitter_stream(global.fx_system_1, global.fx_emitter_1, global.particle_2, 8);

global.particle_1 = part_type_create();
part_type_sprite(global.particle_1 , spr_particles_blood, false, false, true);
part_type_size(global.particle_1, 1, 1, 0, 0);
part_type_scale(global.particle_1, 1, 1);
part_type_colour1(global.particle_1, c_white);
part_type_alpha2(global.particle_1, 1, 0);
part_type_speed(global.particle_1, 4, 10, -0.2, 0);
part_type_direction(global.particle_1, 0, 360, 0, 0);
//part_type_gravity(global.particle_1, 0.5, 270);
part_type_orientation(global.particle_1, 0, 0, 0, 0, true);
part_type_blend(global.particle_1, false);	// change to true to have particles blend additively with background
part_type_life(global.particle_1, 15, 25);



global.particle_2 = part_type_create();
part_type_sprite(global.particle_1 , spr_particles_item, false, false, true);
part_type_size(global.particle_1, 1, 1, 0, 0);
part_type_scale(global.particle_1, 1, 1);
part_type_colour1(global.particle_1, c_white);
part_type_alpha2(global.particle_1, 1, 0);
part_type_speed(global.particle_1, 2, 3, 0, 0);
part_type_direction(global.particle_1, 70, 110, 0, 0);
//part_type_gravity(global.particle_1, 0.5, 270);
part_type_orientation(global.particle_1, 0, 0, 0, 0, true);
part_type_blend(global.particle_1, false);	// change to true to have particles blend additively with background
part_type_life(global.particle_1, 8, 12);


global.fx_system_2 = part_system_create_layer("Layer_Objects", true);
global.fx_emitter_2 = part_emitter_create(global.fx_system_2);
global.death_particles = part_type_create();

part_type_shape(global.death_particles, pt_shape_pixel);
part_type_size(global.death_particles, 3, 6, -1, 0);
part_type_scale(global.death_particles, 1, 1);
part_type_colour1(global.death_particles, color_health);
part_type_alpha2(global.death_particles, 1, 0);
part_type_speed(global.death_particles, 12, 20, 0, 0);
part_type_direction(global.death_particles, 40, 120, 0, 0);
part_type_gravity(global.death_particles, 4, 270);
part_type_blend(global.death_particles, 0);
part_type_life(global.death_particles, 60, 60);
//global.particles[| particles.death_particles] = global.death_particles;




global.item_particles_common = part_type_create();
part_type_shape(global.item_particles_common, pt_shape_pixel);
part_type_size(global.item_particles_common, 1, 1, 0, 0);
part_type_scale(global.item_particles_common, 1, 1);
part_type_colour1(global.item_particles_common, c_white);
part_type_alpha2(global.item_particles_common, 0.2, 0);
part_type_speed(global.item_particles_common, 0, 2, 0, 0);
part_type_direction(global.item_particles_common, 45, 135, 0, 0);
part_type_gravity(global.item_particles_common, 0, 0);
part_type_blend(global.item_particles_common, 0);
part_type_life(global.item_particles_common, 10, 15);

global.item_particles_uncommon = part_type_create();
part_type_shape(global.item_particles_uncommon, pt_shape_pixel);
part_type_size(global.item_particles_uncommon, 1, 1, 0, 0);
part_type_scale(global.item_particles_uncommon, 1, 1);
part_type_colour1(global.item_particles_uncommon, c_yellow);
part_type_alpha2(global.item_particles_uncommon, 0.3, 0);
part_type_speed(global.item_particles_uncommon, 0, 2, 0, 0);
part_type_direction(global.item_particles_uncommon, 40, 140, 0, 0);
part_type_gravity(global.item_particles_uncommon, 0, 0);
part_type_blend(global.item_particles_uncommon, 0);
part_type_life(global.item_particles_uncommon, 15, 20);

global.item_particles_rare = part_type_create();
part_type_shape(global.item_particles_rare, pt_shape_pixel);
part_type_size(global.item_particles_rare, 1, 1, 0, 0);
part_type_scale(global.item_particles_rare, 1, 1);
part_type_colour1(global.item_particles_rare, c_blue);
part_type_alpha2(global.item_particles_rare, 0.5, 0);
part_type_speed(global.item_particles_rare, 0, 2, 0, 0);
part_type_direction(global.item_particles_rare, 35, 145, 0, 0);
part_type_gravity(global.item_particles_rare, 0, 0);
part_type_blend(global.item_particles_rare, 0);
part_type_life(global.item_particles_rare, 20, 25);

global.item_particles_set = part_type_create();
part_type_shape(global.item_particles_set, pt_shape_pixel);
part_type_size(global.item_particles_set, 1, 1, 0, 0);
part_type_scale(global.item_particles_set, 1, 1);
part_type_colour1(global.item_particles_set, c_lime);
part_type_alpha2(global.item_particles_set, 0.4, 0);
part_type_speed(global.item_particles_set, 0, 2, 0, 0);
part_type_direction(global.item_particles_set, 20, 160, 0, 0);
part_type_gravity(global.item_particles_set, 0, 0);
part_type_blend(global.item_particles_set, 0);
part_type_life(global.item_particles_set, 25, 30);

global.item_particles_unique = part_type_create();
part_type_shape(global.item_particles_unique, pt_shape_pixel);
part_type_size(global.item_particles_unique, 1, 1, 0, 0);
part_type_scale(global.item_particles_unique, 1, 1);
part_type_colour1(global.item_particles_unique, c_fuchsia);
part_type_alpha2(global.item_particles_unique, 0.5, 0);
part_type_speed(global.item_particles_unique, 0, 2, 0, 0);
part_type_direction(global.item_particles_unique, 20, 160, 0, 0);
part_type_gravity(global.item_particles_unique, 0, 0);
part_type_blend(global.item_particles_unique, 0);
part_type_life(global.item_particles_unique, 25, 30);

global.item_particles_pickup = part_type_create();
part_type_shape(global.item_particles_pickup, pt_shape_pixel);
part_type_size(global.item_particles_pickup, 1, 5, -0.3, 0);
part_type_scale(global.item_particles_pickup, 1, 1);
part_type_colour1(global.item_particles_pickup, c_white);
part_type_alpha2(global.item_particles_pickup, 0.6, 0);
part_type_speed(global.item_particles_pickup, 1, 14, 0, 0);
part_type_direction(global.item_particles_pickup, 0, 360, 0, 90);
part_type_gravity(global.item_particles_pickup, 0, 0);
part_type_blend(global.item_particles_pickup, 0);
part_type_life(global.item_particles_pickup, 25, 30);
//global.particles[| particles.death_particles] = global.death_particles;

color_potion_dark = make_color_rgb(179, 234, 93); //(58, 76, 58); //(51, 97, 90); //(63, 116, 77);
color_potion_light = make_color_rgb(225,255,178); //(205, 255, 127); //(108, 172, 75);

global.potion_particles = part_type_create();

part_type_shape(global.potion_particles, pt_shape_pixel);
part_type_size(global.potion_particles, 2, 5,-0.1, 0.2);
part_type_scale(global.potion_particles, 1, 1);
part_type_colour1(global.potion_particles, color_potion_dark);
part_type_alpha2(global.potion_particles, 1, 0.3);
part_type_speed(global.potion_particles, 0.5, 3, 0, 0);
part_type_direction(global.potion_particles, 70, 110, 0, 90);
part_type_gravity(global.potion_particles, 0, 0);
part_type_blend(global.potion_particles, 0);
part_type_life(global.potion_particles, 40, 60);
//global.particles[| particles.death_particles] = global.death_particles;

global.potion_particles_light = part_type_create();

part_type_shape(global.potion_particles_light, pt_shape_pixel);
part_type_size(global.potion_particles_light, 1, 4,-0.1, 0.2);
part_type_scale(global.potion_particles_light, 1, 1);
part_type_colour1(global.potion_particles_light, color_potion_light);
part_type_alpha2(global.potion_particles_light, 1, 0.3);
part_type_speed(global.potion_particles_light, 0.5, 6, 0, 0);
part_type_direction(global.potion_particles_light, 70, 110, 0, 90);
part_type_gravity(global.potion_particles_light, 0, 0);
part_type_blend(global.potion_particles_light, 0);
part_type_life(global.potion_particles_light, 40, 60);
//global.particles[| particles.death_particles] = global.death_particles;

global.dash_particles = part_type_create();

part_type_shape(global.dash_particles, pt_shape_pixel);
part_type_size(global.dash_particles, 1, 3, 0.25, 0);
part_type_scale(global.dash_particles, 1, 1);
part_type_colour1(global.dash_particles, c_gray);
part_type_alpha2(global.dash_particles, 0.3, 0);
part_type_speed(global.dash_particles, 2, 6, 0, 0);
part_type_direction(global.dash_particles, 180, 180, 0, 0);
part_type_gravity(global.dash_particles, 0.15, 90);
part_type_blend(global.dash_particles, 0);
part_type_life(global.dash_particles, 20, 30);
//global.particles[| particles.death_particles] = global.death_particles;


var life_steal_particles = part_type_create();

part_type_shape(life_steal_particles, pt_shape_pixel);
part_type_size(life_steal_particles, 2, 5, 0, 0);
part_type_scale(life_steal_particles, 1, 1);
part_type_colour1(life_steal_particles, c_red);
part_type_alpha2(life_steal_particles, 1, 0);
part_type_speed(life_steal_particles, 0, 1, 3, 0);
part_type_direction(life_steal_particles, 0, 0, 0, 0);
part_type_gravity(life_steal_particles, 0, 0);
part_type_life(life_steal_particles, game_get_speed(gamespeed_fps), game_get_speed(gamespeed_fps));
global.particles[| particles.life_steal_particles] = life_steal_particles;

/*
global.footprint_particles = part_type_create();
part_type_shape(global.footprint_particles, spr_footprint);
part_type_size(global.footprint_particles, 1, 1,0, 0);
part_type_scale(global.footprint_particles, 1, 1);
part_type_alpha2(global.footprint_particles, 1, 0);
part_type_speed(global.footprint_particles, 0, 0, 0, 0);
part_type_direction(global.footprint_particles, 0, 0, 0, 0);
part_type_gravity(global.footprint_particles, 0, 0);
part_type_blend(global.footprint_particles, 0);
part_type_life(global.footprint_particles, 30, 30);
*/

var size = 3;
display_warning = false;
attribute_points = size;
clicked_spend = false;
attr_grid = ds_grid_create(size, size);
color_attr_points = make_color_rgb(45, 41, 61);
for (var i = 0; i < ds_grid_height(attr_grid); i++)
{
	for (var j = 0; j < ds_grid_width(attr_grid); j++)
	{
		if (j == 0)
			attr_grid[# i, j] = 1;
		else
			attr_grid[# i, j] = 0;
	}
}

