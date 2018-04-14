
var inv_sprite = spr_inv_9slice_1;
var slice_size = 6;

var panel_x = global.view_width / 5;
var panel_x2 = global.view_width - panel_x;
var panel_y = 12;
var panel_y2 = global.view_height - 12;

NineSliceStretched(inv_sprite, panel_x, panel_y, panel_x2, panel_y2, 1);

var current_stats = obj_character_sheet.stat_bible;

draw_set_halign(fa_left);
draw_set_font(fnt_start);
var text_start_x = panel_x + (2 * slice_size);
var text_start_y = panel_y + (2 * slice_size)
var stat_scale = 0.1;

var counter = 0;
for (var i = 0; i < ds_list_size(global.stat_list); i ++)
{
	var stat = global.stat_list[| i];
	var current_stat = current_stats[? stat];
	if (stat == stats.cast_skill_on_striking || stat == stats.cast_skill_when_struck ||
		stat == stats.class_skill_tree || stat == stats.class_skills || stat == stats.specific_skill ||
		stat == stats.immunity_to_status_effect || stat == stats.reduced_duration_to_status_effect)
	{
		//show_debug_message("not printing this stat");
	}
	else
	{

		var stat_string = StatToString(current_stat);
		draw_text_transformed(text_start_x, text_start_y + (counter * string_height(stat_string) * stat_scale) + (counter * 1), 
		string_upper(stat_string), stat_scale, stat_scale, 0);
		counter ++;
	}
}
draw_set_font(fnt_rogue);