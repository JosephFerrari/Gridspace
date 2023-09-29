/// @description Draw Background

// Grid

for (var ypos = 0; ypos < room_height; ypos += sprite_get_height(spr_grid))
{
	for (var xpos = 0; xpos < room_width; xpos += sprite_get_width(spr_grid))
	{
		draw_sprite(spr_grid, 0, xpos, ypos);
	}
}