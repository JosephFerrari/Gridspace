/// @description Initialize Variables

// Constants

#macro TILE 16
#macro WIDTH 7
#macro HEIGHT 11

// Utility

function smooth(_value)
{
	return (dsin((_value * 180) - 90) + 1) / 2;
}

// Control

global.entities = ds_list_create();
active_entity = noone;
transition = 0;

function next_entity()
{
	var index = ds_list_find_index(global.entities, active_entity) + 1;
	if (index < ds_list_size(global.entities)) active_entity = global.entities[| index];
	else
	{
		active_entity = noone;
		transition = 0;
	}
}

// Structs

function str_entity(_x, _y, _spr, _actions = noone) constructor
{
    x = floor(_x);
    y = floor(_y);
	spr = _spr;
	w = sprite_get_width(spr) / TILE;
	h = sprite_get_height(spr) / TILE;
	
	actions = _actions;
	action_index = 0;
	dir = sign(floor(WIDTH / 2) - x);
	
	x_proposal = x;
	y_proposal = y;
	x_cache = x;
	y_cache = y;
	
	static act = function()
	{
		if (actions == noone) return;
		var action = actions[action_index];
		
		x_proposal = x + action.x * (dir == 0 ? 1 : dir);
		y_proposal = y + action.y;
		var reject = false;
		if (x_proposal < 0 || x_proposal > WIDTH - w || y_proposal < 0 || y_proposal > HEIGHT - h) reject = true;
		if (ds_exists(global.entities, ds_type_list))
		{
			for (var i = 0; i < ds_list_size(global.entities); i++)
			{
				var entity = global.entities[| i];
				if (entity == self) continue;
				if (x_proposal == entity.x && y_proposal == entity.y) reject = true;
			}
		}
		if (reject && action.x != 0) dir *= -1;
		x_cache = x;
		y_cache = y;
		if (!reject)
		{
			x = x_proposal;
			y = y_proposal;
		}
		
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

player = new str_entity(WIDTH / 2, HEIGHT / 2, spr_player);
ds_list_add(global.entities, player);
ds_list_add(global.entities, spawn_glider(1));