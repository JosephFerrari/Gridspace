/// @description Game Logic

// Controls

var left = keyboard_check_pressed(vk_left);
var right = keyboard_check_pressed(vk_right);
var up = keyboard_check_pressed(vk_up);
var down = keyboard_check_pressed(vk_down);

// Player

if (active_entity == noone)
{
	if (left) player.actions[0] = action_horizontal(-1);
	if (right) player.actions[0] = action_horizontal(1);
	if (up) player.actions[0] = action_vertical(-1);
	if (down) player.actions[0] = action_vertical(1);
	if (left || right || up || down) active_entity = player;
}

// Action Queue

if (active_entity != noone)
{
	if (transition <= 0)
	{
		active_entity.act();
		transition = 0;
	}
	transition += (delta_time / 1000000) * 10;
	if (transition >= 1)
	{
		next_entity();
		transition = 0;
	}
}

// Debug

if (keyboard_check_pressed(vk_escape)) game_end();