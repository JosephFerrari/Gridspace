/// @description Game Logic

// Debug

if (keyboard_check_pressed(vk_escape)) game_end();

// Timing

var delta = delta_time / 1000000;

// Controls

var left = keyboard_check_pressed(vk_left);
var right = keyboard_check_pressed(vk_right);
var up = keyboard_check_pressed(vk_up);
var down = keyboard_check_pressed(vk_down);
var shoot = keyboard_check_pressed(ord("Z"));
var laser = keyboard_check_pressed(ord("X"));

// Interface

if (intro)
{
	if (shoot) intro = false;
	return;
}
if (window_transition < 1) window_transition += delta * 5;
else if (window_transition > 1) window_transition = 1;

// Visual
frame += delta * 20;

// Action

if (transition >= 1)
{
	if (player.hits <= 0) return;
	if (left) player.actions[0] = action.move_left;
	if (right) player.actions[0] = action.move_right;
	if (up) player.actions[0] = action.move_up;
	if (down) player.actions[0] = action.move_down;
	if (shoot)
	{
		if (energy >= WEAK) player.actions[0] = action.shoot_up;
		else shoot = false;
	}
	if (laser)
	{
		if (energy >= STRONG) player.actions[0] = action.laser_up;
		else laser = false;
	}
	if (left || right || up || down || shoot || laser)
	{
		if (shoot) energy -= WEAK;
		else if (laser) energy -= STRONG;
		else if (energy < ENERGY) energy++;
		for (var i = 0; i < array_length(global.effects); i++)
		{
			var effect = global.effects[i];
			if (effect.persist)
			{
				array_delete(global.effects, i, 1);
				delete effect;
				i--;
			}
		}
		while (queue_pos < array_length(queue) && queue[queue_pos].turn == turn)
		{
			queue[queue_pos].spawn();
			queue_pos++;
		}
		array_foreach(global.entities, function(_entity) { _entity.set_up(); });
		array_foreach(global.entities, function(_entity) { _entity.propose(); });
		array_foreach(global.entities, function(_entity) { _entity.check_collision(); });
		array_foreach(global.entities, function(_entity) { _entity.retract(); });
		array_foreach(global.entities, function(_entity) { _entity.check_collision(); });
		array_foreach(global.entities, function(_entity) { _entity.check_hits(false); });
		array_foreach(global.entities, function(_entity) { _entity.check_hits(true); });
		array_foreach(global.entities, function(_entity) { _entity.lock(); });
		array_foreach(global.entities, function(_entity) { _entity.wrap_up(); });
		transition = 0;
	}
}
else
{
	transition += delta * 5;
	if (transition >= 1)
	{
		for (var i = 0; i < array_length(global.entities); i++)
		{
			var entity = global.entities[i];
			if (entity.hits <= 0 || entity.x < 0 || entity.x + entity.w > WIDTH || entity.y + entity.h <= 0 || entity.y + entity.h > HEIGHT)
			{
				if (entity.spr == spr_mothership) winner = true;
				array_delete(global.entities, i, 1);
				array_foreach(entity.actions, function(_action) { delete _action; });
				delete entity;
				i--;
			}
		}
		transition = 1;
		turn++;
	}
}