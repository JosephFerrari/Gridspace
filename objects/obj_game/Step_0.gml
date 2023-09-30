/// @description Game Logic

// Controls

var left = keyboard_check_pressed(vk_left);
var right = keyboard_check_pressed(vk_right);
var up = keyboard_check_pressed(vk_up);
var down = keyboard_check_pressed(vk_down);
var shoot = keyboard_check_pressed(vk_space);

// Player

if (active_entity == noone)
{
	if (left) player.actions[0] = action_move_x(-1);
	if (right) player.actions[0] = action_move_x(1);
	if (up) player.actions[0] = action_move_y(-1);
	if (down) player.actions[0] = action_move_y(1);
	if (shoot) player.actions[0] = action_shoot(-1);
	if (left || right || up || down || shoot) active_entity = player;
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
		transition = 0;
		next_entity();
	}
}

// Debug

if (keyboard_check_pressed(vk_escape)) game_end();