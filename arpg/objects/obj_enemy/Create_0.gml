enemy_health_max = 20;
enemy_health_current = enemy_health_max;
enemy_deflection = 0.15;
name = "spr_ogre_blue";
last_direction = 1;
is_bleeding = false;
is_flashing = false;
is_deflecting = false;
bleed_frame = 0;
deflect_frame = 0;
deflect_angle = 0;
deflect_size = 1;
inactive = false;
//cloaked = false;
blood_sprite = global.blood_sprites[| 0];//irandom_range(0, ds_list_size(global.blood_sprites) - 1)];

animation_state = anim.idle_right;
is_hurt = false;
hurt_frame = 0;
just_got_hurt = true;

is_melee_attacking = false;
just_started_attacking = true;
created_collider = false;


enemy_accuracy = 100;