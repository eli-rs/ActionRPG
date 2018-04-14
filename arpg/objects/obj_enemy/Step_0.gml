

	
if (hspeed > 0)
{
	animation_state = anim.run_right;
	//sprite_index = asset_get_index(sprite + "_run_right");
	
}
else if (hspeed < 0)
{
	animation_state = anim.run_left;
	//sprite_index = asset_get_index(sprite + "_run_left");
}

if (hspeed != 0)
	last_direction = sign(hspeed);

if (speed = 0) 
{

	if (last_direction == -1)
		animation_state = anim.idle_left;
		//sprite_index = asset_get_index(sprite + "_idle_left");
	else
		animation_state = anim.idle_right;
		//sprite_index = asset_get_index(sprite + "_idle_right");
}
else image_speed = speed / 2;

if (is_hurt)
{
	if (just_got_hurt)
	{
		is_bleeding = true;
		image_index = 0;
		just_got_hurt = false;
	}
	// if facing right: anim = hurt_right, facing left: anim = hurt_left
	animation_state = last_direction > 0 ? anim.hurt_right : anim.hurt_left;
	inactive = true;
	if (image_index > image_number - 1)
	{
		is_hurt = false
		inactive = false;
	}
}

if (is_melee_attacking)
{
	if (just_started_attacking)
	{
		image_index = 0;
		just_started_attacking = false;
		created_collider = false;
	}
	if (created_collider == false && image_index >= 3) 
	{	
		created_collider = true;
		MeleeAttack();
	}
	// if facing right: anim = hurt_right, facing left: anim = hurt_left
	animation_state = last_direction > 0 ? anim.attack_right : anim.attack_left;
	inactive = true;
	if (image_index > image_number - 1)
	{
		is_melee_attacking = false
		inactive = false;
	}
}

sprite_index = asset_get_index(name + global.animation_states[? animation_state]);


if (enemy_health_current <= 0)
{
	if (global.settings[? "enemy_death_particles"] == true)
	{
		part_system_position(global.fx_system_2, x, y);
		part_emitter_burst(global.fx_system_2, global.fx_emitter_2, global.death_particles, irandom(enemy_rarity * 5));
	}
	inactive = true;
	if (is_bleeding == false)
		instance_destroy();
}

