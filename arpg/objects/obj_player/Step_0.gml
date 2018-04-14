/* TO DO: Create sprites of idle-animations for each direction and then have all animations 
 *			reverts to their direction's idle anim once horizSpeed == 0 && vertSpeed == 0
 *			to do this keep track of the most recently moved in direction and set 
 *			sprite_index = idle_that_direction 
 */
if (global.paused) 
{
	can_melee_attack = false;
	can_ranged_attack = false;
}
if (global.inventory_open || global.character_sheet_open) 
{
	can_melee_attack = false;
	can_ranged_attack = false;
}
if (isInteracting) 
{
	can_melee_attack = false;
	can_ranged_attack = false;
}
if (absorbing != -1)
{
	var total_duration = ds_list_size(absorbed_damage);
	var damage_per_step = absorbing / total_duration;
	for (var i = 0; i < total_duration; i++)
		absorbed_damage[| i] = absorbed_damage[| i] + damage_per_step;
		
	absorbing = -1;
}

//=====================INPUT HANDLING
#region Input Handling
var up = keyboard_check(ord("W")) || keyboard_check(vk_up);
var left = keyboard_check(ord("A")) || keyboard_check(vk_left);
var down = keyboard_check(ord("S")) || keyboard_check(vk_down);
var right = keyboard_check(ord("D")) || keyboard_check(vk_right);
#endregion

#region Potion Drinking
if (keyboard_check_pressed(ord("E")) && (player_health_current != global.player_stats[? derived_stats.life]))
{
	if (player_potion_reset_timer <= 0)
	{
		player_health_current = min(global.player_stats[? derived_stats.life], player_health_current + health_potion_value);
		player_potion_reset_timer = player_potion_reset_time;
		
		part_system_position(global.fx_system_3, x, y);
		part_emitter_burst(global.fx_system_3, global.fx_emitter_3, global.potion_particles, 60);
		part_emitter_burst(global.fx_system_3, global.fx_emitter_3, global.potion_particles_light, 40);
	}
}
if (player_potion_reset_timer > 0) player_potion_reset_timer -= 1;
#endregion

//=====================SKILL USAGE
#region Check for Skill Usage, Execute Skill Script on Use
// foreach skill in playerskills, check if skill is usable checking timer
// foreach skill in playerskills, check if skill is usable checking timer
// if skill is usable and player is trying to use it, then reset timer and execute skill
// otherwise just decrement the skill's timer

for (var i = 0; i < ds_list_size(global.player_skills); i ++)
{
	var skill_map = global.player_skills[| i];
	if (skill_map[? "timer"] <= 0)
	{
		if (keyboard_check_pressed( ord(string(i + 1)) ) )
		{
			//show_debug_message("PLAYER PRESSED SKILL: " + string(i));
			script_execute(skill_map[? "script"], player_skill_levels[| i]);
			skill_map[? "timer"] = skill_map[? "cooldown"] * game_get_speed(gamespeed_fps);
		}
	}
	else
		skill_map[? "timer"] -= 1;
}
#endregion

//=====================MOVEMENT
#region Movement
var horiz = right - left;
var vert = down - up;

if (left) horizSpeed -= accelSpeed;
if (right) horizSpeed += accelSpeed;
if (up) vertSpeed -= accelSpeed;
if (down) vertSpeed += accelSpeed;

if (horizSpeed > maxSpeed) horizSpeed = maxSpeed;
if (horizSpeed < -maxSpeed) horizSpeed = -maxSpeed;
if (vertSpeed > maxSpeed) vertSpeed = maxSpeed;
if (vertSpeed < -maxSpeed) vertSpeed = -maxSpeed;


if (horiz == 0) 
{
	if (horizSpeed - accelSpeed >= 0) horizSpeed -= accelSpeed;
	else if (horizSpeed >= 0) horizSpeed = 0;
	else 
	{
		if (horizSpeed + accelSpeed <= 0) horizSpeed += accelSpeed;
		else if (horizSpeed < 0) horizSpeed = 0;
	}
}
if (vert == 0)
{
	if (vertSpeed - accelSpeed >= 0) vertSpeed -= accelSpeed;
	else if (vertSpeed >= 0) vertSpeed = 0;
	else
	{
		if (vertSpeed + accelSpeed <= 0) vertSpeed += accelSpeed;
		else if (vertSpeed < 0) vertSpeed = 0;
	}
}
#endregion

//=====================ANIMATION
#region Animation
// if we are moving up moreso than horizontally, display/animate walk-up sprite
if (vertSpeed < 0 && abs(vertSpeed) >= abs(horizSpeed)) 
{
	sprite_index = spr_player_walk_up;
	image_speed = abs(vertSpeed) / 3;
}
else if (vertSpeed > 0 && vertSpeed >= abs(horizSpeed))
{
	sprite_index = spr_player_walk_down;
	image_speed = vertSpeed / 3;
}

else 
{
	
	if (horizSpeed > 0) 
	{
		sprite_index = spr_player_walk_right;
		image_speed = horizSpeed / 3;
	}
	else if (horizSpeed < 0) {
		sprite_index = spr_player_walk_left;
		image_speed = abs(horizSpeed) / 3;
	}
	
	else if (vertSpeed = 0) image_speed = 0;
}
#endregion

//=====================RANGED ATTACK
#region Create Ranged Projectile on Right Click
if (global.in_game
	&& mouse_check_button(mb_right) // check whether weapon is autofire or manual
	&& can_ranged_attack
	&& player_stamina_current >= player_ranged_attack_stamina_cost)
{
	is_ranged_attacking = true;
	//animating_bow = true;
}
if (is_ranged_attacking)
{
	can_ranged_attack = false;
	
	PlayerRangedAttack();
	
	is_ranged_attacking = false;
	player_ranged_attack_timer = player_ranged_attack_reset_time;
}
else 
{
	if (player_ranged_attack_timer > 0) 
		player_ranged_attack_timer -= 1;
	else
		can_ranged_attack = true;
}


#endregion

//=====================MELEE ATTACK
#region Create Melee Hitbox on Left Click
if (global.in_game 
	&& mouse_check_button_pressed(mb_left) 
	&& can_melee_attack 
	&& player_stamina_current >= player_melee_attack_stamina_cost)
{
	is_melee_attacking = true;
}
if (is_melee_attacking)
{
	
	can_melee_attack = false;
	player_stamina_current -= player_melee_attack_stamina_cost;
	// we determine and normalize the vector between player loc and mouse click, this is
	// used to place the hitbox at the precisely correct angle and distance from player
	var x_diff = mouse_x - x;
	var y_diff = mouse_y - y;
	
	var magnitude = sqrt(sqr(x_diff) + sqr(y_diff));
	var norm_x = x_diff / magnitude;
	var norm_y = y_diff / magnitude;
	
	var x_mult = sprite_width / 2;
	var y_mult = sprite_height / 2;
	
	// we also add the player speed to the position to account for player's movement while 
	// the hitbox animation is playing
	var hitbox_frames = sprite_get_number(player_hitbox);

	var hitbox_x = x + (norm_x * x_mult) + (horizSpeed * hitbox_frames);
	var hitbox_y = y + (norm_y * y_mult) + (vertSpeed * hitbox_frames);
	
	if (swap_directions)
	{
		player_hitbox = asset_get_index(sprite_get_name(player_hitbox) + "_alt");
		swap_directions = false;
	}
	else
	{
		var spritename = sprite_get_name(player_hitbox);
		var idx = string_length(spritename) - 3;
		var new_name = string_delete(spritename, idx, 4);
		player_hitbox = asset_get_index(new_name);
		swap_directions = true;
	}
	
	var hit_box = instance_create_layer(hitbox_x, hitbox_y, layer, obj_hitbox);
	


	with(hit_box)
	{
		// set the hit_box angle toward where clicked
		image_angle = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
		// set the hitbox damage and other player_given variables
		damage_range = obj_player.player_melee_damage;
		crit_chance = obj_player.player_crit_chance;
		crit_mult = obj_player.player_crit_damage;
	}
	is_melee_attacking = false;
	player_melee_attack_timer = player_melee_attack_reset_time;
	
}
else 
{
	if (player_melee_attack_timer > 0) 
		player_melee_attack_timer -= 1;
	else
	{
		can_melee_attack = true;
	}
}

#endregion

//=====================DASH
#region Dash
// check to see if player is trying to dash (and isn't just idle)
if (keyboard_check(vk_space) 
	&& (horizSpeed != 0 || vertSpeed != 0) 
	&& canDash 
	&& player_stamina_current >= dash_stamina_cost)
		isDashing = true;


if (isDashing)
{
	// once we are dashing we subtract stamina cost and cannot dash again until dashTimer resets
	canDash = false;

	
	var dash_obj = instance_create_layer(x, y, layer, obj_dash_effect);

	// then we determine which sprite should be used for the dash effect (to match player movement)
	var dashMovement;
	if (abs(horizSpeed) > abs(vertSpeed))
		dashMovement = "horizontal";
	else
		dashMovement = "vertical";
	if (dashMovement == "horizontal")
	{
		dash_obj.sprite_index = spr_player_walk_right;
		if (horizSpeed > 0) dash_obj.image_xscale = 1;
		else if (horizSpeed < 0) dash_obj.image_xscale = -1;
	}
	else
	{
		if (vertSpeed > 0) dash_obj.sprite_index = spr_player_walk_down;
		else if (vertSpeed < 0) dash_obj.sprite_index = spr_player_walk_up;
	}
	
	// if our dash has just begun, subtract appropriate amount of stamina
	if (dashTimer == dashTime)
		player_stamina_current -= dash_stamina_cost;
		
	dashTimer -= 1;
	if (dashTimer <= 0){
		isDashing = false;
		dashTimer = dashTime;
		dashResetTimer = dashResetTime;
	}
}
else 
{
	if (dashResetTimer > 0)
		dashResetTimer -= 1;
	else 
	{
		canDash = true;
	}
	
}
#endregion

//=====================POSITION CHANGE
#region Translate Movement into Actual Position Change
var xmovement = 0;
var ymovement = 0;
var movespeed = (1 + (global.player_stats[? derived_stats.movement_speed] / 100));
if (!isDashing) {
	xmovement = horizSpeed * movespeed;
	ymovement = vertSpeed * movespeed;
}
else {
	xmovement = horizSpeed * dashSpeed * movespeed;
	ymovement = vertSpeed * dashSpeed * movespeed;
}
x += xmovement;
y += ymovement;

#endregion

//=====================PLAYER DEATH CHECK
#region Kill Player When Health < 0
if (player_health_current > global.player_stats[? derived_stats.life])
	player_health_current = global.player_stats[? derived_stats.life];
else if (player_health_current <= 0)
{
	game_end();
}

// alarm set to go off once per second
if (alarm_get(0) <= 0)
	alarm_set(0, 1 * game_get_speed(gamespeed_fps));

#endregion

//=====================REGAIN STAMINA OVER TIME
#region Increase Stamina in Proportion to Fullness of Stamina Bar
if (player_stamina_current != player_stamina_max)
{
	if (player_stamina_current > player_stamina_max)
		player_stamina_current = player_stamina_max;
	else if (player_stamina_current < player_stamina_max)
	{
		if (player_stamina_current + player_stamina_rate > player_stamina_max)
			player_stamina_current = player_stamina_max;
		else if (player_stamina_current == 0)
			player_stamina_current += player_stamina_rate;
		else
		{
			var stamina_mult = ceil( 
				(player_stamina_current / player_stamina_max) 
				* player_stamina_accel_const
				);
			player_stamina_current += player_stamina_rate * stamina_mult;
		}
	}
}
#endregion

//=====================ANIMATE HEALTH BAR ON DAMAGE TAKEN
#region When Player Takes Damage, Animate Damage Taken Behind Health Bar
// If the player's health has changed, do the following
if (player_health_current != player_health_changed)
{
	// If the player has specifically LOST health then:
	if (player_health_current < player_health_changed)
	{
		var health_lost = player_health_changed - player_health_current;
		player_health_back_current = player_health_changed - min(health_lost, lerp(0, health_lost, 
			(player_level / (health_lost)) * animating_health_frame));
		animating_health_frame += 1;
		
		if (player_health_back_current == player_health_current)
		{
			animating_health_frame = 0;
			player_health_changed = player_health_current;
		}
		
	}
	if (player_health_current > player_health_changed)
	{
		var heal_amount = player_health_current - player_health_changed;
		player_health_changed = player_health_current;
		player_health_back_current = player_health_current;
		
		if (round(heal_amount) > 0)
		{
			var text_x = x;
			var text_y = y - (sprite_height * (2/3));
			var text_obj = instance_create_layer(text_x, text_y, "Layer_Objects", obj_heal_text);
			text_obj.amount = round(heal_amount);
		}
	

	}
}
#endregion

