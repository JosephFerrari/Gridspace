/// @description Draw Background

// Grid
for (var ypos = 0; ypos < room_height; ypos += 32)
{
	for (var xpos = 0; xpos < room_width; xpos += 32)
	{
		draw_sprite(spr_grid, 0, xpos, ypos);
	}
}