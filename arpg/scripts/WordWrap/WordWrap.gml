
var wrap_map = ds_map_create();
var unwrapped_string = argument0;
var char_max = argument1;
var num_line_breaks = 0;
		
if (string_length(unwrapped_string) > char_max)
{
	var next_i = char_max;
	var remaining_text = unwrapped_string;
	while (string_length(remaining_text) > char_max)
	{
		remaining_text = ""; 
		for (var i = next_i; i >= 0; i--)
		{					
			if (string_char_at(unwrapped_string, i) == " "){

				for (var c = i; c < string_length(unwrapped_string); c++)
					remaining_text += string_char_at(unwrapped_string, c);
						
				unwrapped_string = string_insert("\n", unwrapped_string, i);
				num_line_breaks ++;
				next_i = i + char_max;
				break;
			}
		}
	}
	ds_map_add(wrap_map, "success", true);
	ds_map_add(wrap_map, "output", unwrapped_string);
	ds_map_add(wrap_map, "line_breaks", num_line_breaks);
	return wrap_map;
}
else
{
	ds_map_add(wrap_map, "success", false);
	ds_map_add(wrap_map, "output", unwrapped_string);
	ds_map_add(wrap_map, "line_breaks", num_line_breaks);
	return wrap_map;
}

