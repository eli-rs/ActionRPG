
var stat_map = argument0;
var stat = stat_map[? "stat"];
var stat_string = global.stat_to_string[? stat];

var new_string = "";
var arg_num = 1;
//show_debug_message("stat_string: " + stat_string);
for (var i = 1; i <= string_length(stat_string); i++)
{
	var char = string_char_at(stat_string, i); // seems like charAt starts counting at 1 and goes to string_length, not 0
	//show_debug_message("current char: " + char);

	if (char == "$")
	{
		var key = "arg" + string(arg_num);
		//show_debug_message("trying arg key: " + key);
		//show_debug_message("string before adding arg: " + new_string);
		if (stat == stats.immunity_to_status_effect || (stat == stats.reduced_duration_to_status_effect && arg_num == 2))
		{
			var status_map = stat_map[? key];
			new_string += status_map[? "name"];
		}
		else if (arg_num == 3 && (stat == stats.cast_skill_on_striking || stat == stats.cast_skill_when_struck))
		{
			var skill_map = stat_map[? key];
			new_string += skill_map[? "name"];
		}
		else if (arg_num == 2 && stat == stats.specific_skill)
		{
			var skill_map = stat_map[? key];
			new_string += skill_map[? "name"];
		}
		else 
		{
			new_string += string(stat_map[? key]);
		}
		//show_debug_message("string after adding arg: " + new_string);
		arg_num += 1;
	}
	else
		new_string += char;
}

return new_string;