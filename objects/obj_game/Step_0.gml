/// @description Game Logic

// Controls

var left = keyboard_check_pressed(vk_left);
var right = keyboard_check_pressed(vk_right);
var up = keyboard_check_pressed(vk_up);
var down = keyboard_check_pressed(vk_down);

// Player

if (left) player.move(-1, 0);
if (right) player.move(1, 0);
if (up) player.move(0, -1);
if (down) player.move(0, 1);

// Debug

if (keyboard_check_pressed(vk_escape)) game_end();