/// @description Draw Background

// Grid

for (var ypos = 0; ypos < room_height; ypos += TILE * 2)
{
	for (var xpos = 0; xpos < room_width; xpos += TILE * 2)
	{
		draw_sprite(spr_grid, 0, xpos, ypos);
	}
}