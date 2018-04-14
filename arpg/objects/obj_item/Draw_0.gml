draw_sprite(spr_item_shadow, 0, x, y);

if (! aura_created)
{
	draw_self();
}
else
{
	if (global.settings[? "item_aura_sprites"] == true)
	{
		draw_sprite_ext(aura_sprite, round(aura_idx), 
			x + (sprite_width / 2), 
			y + (sprite_height / 2),
			aura_scale, aura_scale, 0, c_white, aura_alpha);
	}
	
	draw_self();
}