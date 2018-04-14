//ON-KILL EFFECTS
event_user(0);
// DROP ITEMS
var num_items = ds_list_size(enemy_loot);
var num_commons = 0;
var num_uncommons = 0;
var num_rares = 0;
var num_uniques = 0;
var num_sets = 0;

for (var i = 0; i < num_items; i++)
{
	var current_item = enemy_loot[| i];
	if (current_item == item_rarity_costs.common)
		num_commons ++;
	else if (current_item == item_rarity_costs.uncommon)
		num_uncommons ++;
	else if (current_item == item_rarity_costs.rare)
		num_rares ++;
	else if (current_item == item_rarity_costs.set)
			num_sets ++;
	else if (current_item == item_rarity_costs.unique)
			num_uniques ++;
}

for (var i = 0; i < num_items; i++)
	{
	var random_index = irandom(ds_list_size(global.items) - 1);
	var random_item = global.items[| random_index];
	
	var xpos = x;// + irandom_range(-30, 30);
	var ypos = y;// + irandom_range(-30, 30);
	
	var item_obj = instance_create_depth(xpos, ypos, depth + 1, obj_item);
	var item_spr;
	var item_type = random_item[? "type"];
	
	// SO THIS ISNT WORKING BUT WE ACTUALLY SHOULD CHANGE THIS REGARDLESS
	// INSTEAD OF CREATING ITEM OBJ AND THEN PASSING EVERY VAR INDIVIDUALLY TO IT
	// WE SHOULD JUST PASS: ITEM_OBJ.ITEM = RANDOM_ITEM;
	
	// AND THEN IN ITEM_OBJ'S CREATE EVENT, IT SHOULD AUTOMATICALLY SET ITS SPRITE AND 
	// EVERYTHING ELSE ACCORDING TO WHAT ITEM WAS PASSED. IDEALLY IT WILL USE THE ITEM_TYPE
	// AND NOT BASE_TYPE, 
	
	item_obj.item_name = random_item[? "name"];
	item_obj.item_description = random_item[? "description"];
	item_obj.item_id = random_item[? "id"];
	item_obj.item_image_index = random_item[? "image_index"];
	item_obj.item_type = random_item[? "base_type"];



	with(item_obj){
		sprite_index = random_item[? "sprite_index"];
		image_index = random_item[? "image_index"];
		image_speed = 0;
	}
}



// DROP CURRENCY
for (var i = 0; i < enemy_gold; i++)
{
	instance_create_depth(x, y, depth + 1, obj_currency_drop);
}


// GIVE PLAYER EXPERIENCE
obj_player.player_experience_current += enemy_experience_given;
if (obj_player.player_experience_current >= obj_player.player_experience_needed)
{
	//LevelUp();	
	
	
	var current_level = obj_player.player_level;
	var new_level = current_level ++;
	var base_exp = 120;
	var excess_exp = obj_player.player_experience_current - obj_player.player_experience_needed;
	var exp_needed = (base_exp * new_level) + (base_exp / 10 * sqr(new_level));

	obj_player.player_level += 1;
	obj_player.player_experience_current = excess_exp;
	obj_player.player_experience_needed = exp_needed;
	obj_main_controller.level_up = true;

	
	
	
	
}