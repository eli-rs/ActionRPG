var col = color_normal;
if (was_crit) col = color_crit;
var xscale = 0.4;
if (was_crit) xscale = 0.5;
draw_text_transformed_color(x, y, string(damage), 0.4, 0.4, 0, col, col, col, col, alpha);
