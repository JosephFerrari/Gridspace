/// @description Utilities

// Mathematical

function smooth(_value)
{
	return (dsin((_value * 180) - 90) + 1) / 2;
}

// Actions

function str_action(_x, _y, _shoot = 0) constructor
{
    x = floor(_x);
    y = floor(_y);
	shoot = _shoot;
}

function create_actions()
{
	var actions array_create(argument_count);
	for (var i = 0; i < argument_count; i++)
	{
		actions[i] = argument[i];
	}
	return actions;
}

function action_move_x(_x) { return new str_action(_x, 0); }
function action_move_y(_y) { return new str_action(0, _y); }
function action_shoot(_dir, _x = 0, _y = 0) { return new str_action(_x, _y, _dir); }

// Entities

function str_entity(_x, _y, _spr, _actions = noone, _parent = noone) constructor
{
    x = floor(_x);
    y = floor(_y);
	spr = _spr;
	w = sprite_get_width(spr) / TILE;
	h = sprite_get_height(spr) / TILE;
	x -= floor(w / 2);
	y -= floor(h / 2);
	
	hits = spr == spr_player ? 3 : w * h;
	
	actions = _actions;
	action_index = 0;
	dir = sign(floor(WIDTH / 2) - x);
	
	parent = _parent;
	
	x_proposal = x;
	y_proposal = y;
	x_cache = x;
	y_cache = y;
	
	static act = function()
	{
		if (actions == noone) return;
		var action = actions[action_index];
		
		show_debug_message(action);
		
		if (action.shoot == 0)
		{
			x_proposal = x + action.x * (dir == 0 ? 1 : dir);
			y_proposal = y + action.y;
			var reject = false;
			if (x_proposal < 0 || x_proposal > WIDTH - w || y_proposal < 0 || y_proposal > HEIGHT - h) reject = true;
			else
			{
				for (var i = 0; i < ds_list_size(global.entities); i++)
				{
					var entity = global.entities[| i];
					if (entity == self) continue;
					if (x_proposal < entity.x + entity.w && x_proposal + w > entity.x && y_proposal < entity.y + entity.h && y_proposal + h > entity.y)
					{
						if (parent != noone || entity.parent != noone)
						{
							hits--;
							entity.hits--;
						}
						else reject = true;
						break;
					}
				}
			}
			if (reject && action.x != 0)
			{
				dir *= -1;
				action_index--;
			}
			x_cache = x;
			y_cache = y;
			if (!reject || parent != noone)
			{
				x = x_proposal;
				y = y_proposal;
			}
		}
		else
		{
			x_proposal = x;
			y_proposal = y;
			x_cache = x;
			y_cache = y;
			var index = ds_list_find_index(global.entities, self) + 1;
			while (index < ds_list_size(global.entities) && global.entities[| index].parent == self) index++;
			ds_list_insert(global.entities, index, new str_entity(x + action.x, y + action.y, action.shoot < 0 ? spr_bullet_up : spr_bullet_down, create_actions(action_move_y(action.shoot)), self))
		}
		
		action_index++;
		action_index %= array_length(actions);
	}
	
	static clone = function(_x = x, _y = y)
	{
		return new str_entity(_x, _y, spr, actions);
	}
}

function spawn_glider(_x) { return new str_entity(_x, -1, spr_glider, create_actions(action_move_y(1), action_shoot(1), action_move_x(1))); }