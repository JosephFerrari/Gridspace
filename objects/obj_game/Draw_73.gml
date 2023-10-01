/// @description Draw Interface

// Window

var window_size = lerp(HEIGHT, HEIGHT - WIDTH, smooth(window_transition));
for (var ypos = 1; ypos < HEIGHT - 1; ypos++)
{
	for (var xpos = HEIGHT - window_size + 1; xpos < HEIGHT - 1; xpos++)
	{
		draw_sprite(spr_window, 4, xpos * TILE, ypos * TILE);
	}
}
for (var ypos = 0; ypos < HEIGHT; ypos++)
{
	draw_sprite(spr_window, 3, (HEIGHT - window_size) * TILE, ypos * TILE);
	draw_sprite(spr_window, 5, (HEIGHT - 1) * TILE, ypos * TILE);
}
for (var xpos = HEIGHT - window_size; xpos < HEIGHT; xpos++)
{
	draw_sprite(spr_window, 1, xpos * TILE, 0);
	draw_sprite(spr_window, 7, xpos * TILE, (HEIGHT - 1) * TILE);
}
draw_sprite(spr_window, 0, (HEIGHT - window_size) * TILE, 0);
draw_sprite(spr_window, 2, (HEIGHT - 1) * TILE, 0);
draw_sprite(spr_window, 6, (HEIGHT - window_size) * TILE, (HEIGHT - 1) * TILE);
draw_sprite(spr_window, 8, (HEIGHT - 1) * TILE, (HEIGHT - 1) * TILE);

// HUD

if (!intro && window_transition >= 1)
{
	for (var i = 1; i <= ENERGY; i++)
	{
		draw_sprite(spr_token, i > energy ? 0 : 1, (WIDTH + 1) * TILE, (ENERGY + 1 - i) * TILE);
	}
	for (var i = 1; i <= HITS; i++)
	{
		draw_sprite(spr_token, i > player.hits ? 0 : 2, (WIDTH + 1) * TILE, (ENERGY + HITS + 2 - i) * TILE);
	}
	draw_sprite(spr_button, energy >= STRONG ? 0 : 1, (WIDTH + 2) * TILE, (ENERGY + 1 - STRONG) * TILE);
	draw_sprite(spr_button, energy >= WEAK ? 2 : 3, (WIDTH + 2) * TILE, (ENERGY + 1 - WEAK) * TILE);
}