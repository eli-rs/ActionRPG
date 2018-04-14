event_inherited();

item_id = -1;
item_image_index = -1;
item_name = "";
item_value = -1;
item_description = "";
item_type = "";
item_rarity = -1;

landed = false;
just_created = true;
initial_y = y;
end_y = y + irandom_range(0, 30);
grav_accel = 1.3; //the amount of speed lost per frame
vert_speed = irandom_range(8, 14);
horiz_speed = random_range(-12, 12);
init_horiz_speed = horiz_speed;

aura_created = false;
aura_idx = 0;
aura_sprite = noone;
aura_alpha = 0;
aura_scale = 1;

particles_made = false;

aura_decreasing = false;
emitter_num = ds_list_size(global.emitters);
global.systems[| ds_list_size(global.systems)] = part_system_create_layer("Layer_Objects", true);
global.emitters[| ds_list_size(global.emitters)] = part_emitter_create(global.systems[| emitter_num]);


