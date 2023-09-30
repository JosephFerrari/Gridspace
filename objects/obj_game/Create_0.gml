/// @description Initialize Variables

// Constants

#macro TILE 16
#macro WIDTH 7
#macro HEIGHT 11

// Structs

function str_entity(_x, _y, _spr, _actions) constructor
{
    x = floor(_x);
    y = floor(_y);
	spr = _spr;
	w = sprite_get_width(spr) / TILE;
	h = sprite_get_height(spr) / TILE;
	
	actions = _actions;
	action_index = 0;
	dir = sign(ceil(WIDTH / 2) - x);
	
	static move = function(_x, _y)
	{
		_x *= dir;
		if (x + _x < 0 || x + _x > WIDTH - w)
		{
			dir *= -1;
			_x *= -1;
		}
		x = clamp(x + _x, 0, WIDTH - w);
		y = clamp(y + _y, 0, HEIGHT - h);
	}
	
	static act = function()
	{
		if (actions == noone) return;
		var action = actions[action_index];
		if (action.x != 0 || action.y != 0) move(action.x, action.y);
		action_index++;
		action_index %= array_length(actions);
	}
}

function str_action(_x, _y) constructor
{
    x = floor(_x);
    y = floor(_y);
}

// Enemies

function create_actions()
{
	var actions array_create(argument_count);
	for (var i = 0; i < argument_count; i++)
	{
		actions[i] = argument[i];
	}
	return actions;
}

function action_horizontal(_x) { return new str_action(_x, 0); }
function action_vertical(_y) { return new str_action(0, _y); }

function spawn_glider(_x) { return new str_entity(_x, -1, spr_glider, create_actions(action_vertical(1), action_horizontal(1))); }

// Entities

entities = ds_list_create();
player = new str_entity(WIDTH / 2, HEIGHT / 2, spr_player, noone);
ds_list_add(entities, player);
ds_list_add(entities, spawn_glider(1));