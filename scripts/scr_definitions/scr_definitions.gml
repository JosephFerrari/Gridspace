/// @description Definitions

// Effects

function str_effect(_spr, _x, _y, _delay = 0, _persist = false) constructor
{
	spr = _spr;
    x = _x;
    y = _y;
	delay = _delay;
	persist = _persist;
	
	f = 0;
}

// Actions

enum action
{
	move_left,
	move_right,
	move_up,
	move_down,
	move_along,
	shoot_up,
	shoot_down,
	charge,
	laser_up,
	laser_down
}

// Entities

function str_entity(_spr, _x = WIDTH / 2, _y = -1, _actions = noone, _parent = noone) constructor
{
	spr = _spr;
	w = sprite_get_width(spr) / TILE;
	h = sprite_get_height(spr) / TILE;
    x = floor(_x) - floor(w / 2);
    y = floor(_y) - floor(h / 2);
	dir = sign((WIDTH / 2) - x);
	
	solid = spr != spr_bullet_up && spr != spr_bullet_down;
	evil = spr != spr_player && spr != spr_bullet_up;
	
	hits = spr == spr_player ? HITS : w * h;
	passed = false;
	
	actions = _actions;
	action_index = 0;
	action_complete = false;
	action_rejected = false;
	projectile_offset = 0;
	
	parent = _parent;
	
	x_proposal = x;
	y_proposal = y;
	x_cache = x;
	y_cache = y;
	x_proposal_cache = x;
	y_proposal_cache = y;
	
	static set_up = function()
	{	
		if (actions == noone) return;
		var next_action = actions[action_index];
		
		action_rejected = false;
		action_complete = true;
		if (next_action == action.shoot_up) array_push(global.entities, new str_entity(spr_bullet_up, x + projectile_offset, y, array_from(action.move_up), self));
		else if (next_action == action.shoot_down) array_push(global.entities, new str_entity(spr_bullet_down, x + projectile_offset, y, array_from(action.move_down), self));
		else if (next_action == action.charge) array_push(global.effects, new str_effect(spr_charge, x + projectile_offset, y, 0, true));
		else action_complete = false;
	}
	
	static propose = function()
	{
		if (actions == noone) return;
		var next_action = actions[action_index];
		
		x_proposal = x;
		y_proposal = y;
		switch (next_action)
		{
			case action.move_left:
				x_proposal--;;
				//if (solid && x_proposal < 0) x_proposal++;
				break;
			case action.move_right:
				x_proposal++;
				//if (solid && x_proposal + w > WIDTH) x_proposal--;
				break;
			case action.move_up:
				y_proposal--;
				//if (solid && y_proposal < 0) y_proposal++;
				break;
			case action.move_down:
				y_proposal++;
				//if (solid && y_proposal + h > HEIGHT) y_proposal--;
				break;
			case action.move_along:
				if (solid && (x_proposal + dir < 0 || x_proposal + dir + w > WIDTH)) dir *= -1;
				x_proposal += dir;
				break;
			default:
				break;
		}
		x_proposal_cache = x_proposal;
		y_proposal_cache = y_proposal;
	}
	
	static check_collision = function()
	{
		if (actions == noone) return;
		
		if (solid && !action_rejected && !action_complete)
		{
			if (x_proposal < 0 || x_proposal + w > WIDTH || y_proposal < 0 || y_proposal + h > HEIGHT) action_rejected = true;
			else
			{
				for (var i = 0; i < array_length(global.entities); i++)
				{
					var entity = global.entities[i];
					if (entity == self || !entity.solid) continue;
					if (entity.action_complete)
					{
						if (x_proposal < entity.x + entity.w && x_proposal + w > entity.x && y_proposal < entity.y + entity.h && y_proposal + h > entity.y) action_rejected = true;
					}
					else
					{
						if (x_proposal < entity.x_proposal + entity.w && x_proposal + w > entity.x_proposal && y_proposal < entity.y_proposal + entity.h && y_proposal + h > entity.y_proposal) action_rejected = true;
						if (x_proposal < entity.x + entity.w && x_proposal + w > entity.x && y_proposal < entity.y + entity.h && y_proposal + h > entity.y && x < entity.x_proposal + entity.w && x + w > entity.x_proposal && y < entity.y_proposal + entity.h && y + h > entity.y_proposal) action_rejected = true;
					}
				}
			}
		}
	}
	
	static retract = function()
	{
		if (actions == noone) return;
		
		if (action_rejected)
		{
			x_proposal = x;
			y_proposal = y;
		}
	}
	
	static check_hits = function(_solid)
	{
		if (!solid && hits > 0)
		{
			if (!_solid) passed = false;
			for (var i = 0; i < array_length(global.entities); i++)
			{
				var entity = global.entities[i];
				if (entity == self || entity.solid != _solid || entity.hits <= 0) continue;
				if (x_proposal < entity.x_proposal + entity.w && x_proposal + w > entity.x_proposal && y_proposal < entity.y_proposal + entity.h && y_proposal + h > entity.y_proposal)
				{
					hits--;
					if (evil != entity.evil)
					{
						entity.hits--;
						if (entity.hits <= 0) array_push(global.effects, new str_effect(entity.solid ? spr_spark : spr_poof, entity.x_proposal, entity.y_proposal, 1));
						else array_push(global.effects, new str_effect(spr_poof, entity.x_proposal, entity.y_proposal, 1));
					}
				}
				if (x_proposal < entity.x + entity.w && x_proposal + w > entity.x && y_proposal < entity.y + entity.h && y_proposal + h > entity.y && x < entity.x_proposal + entity.w && x + w > entity.x_proposal && y < entity.y_proposal + entity.h && y + h > entity.y_proposal)
				{
					hits--;
					passed = true;
					if (evil != entity.evil)
					{
						entity.hits--;
						entity.passed = true;
						if (entity.hits <= 0) array_push(global.effects, new str_effect(entity.solid ? spr_spark : spr_poof, (x + entity.x) / 2, (y + entity.y) / 2, 0.5));
						else array_push(global.effects, new str_effect(spr_poof, (x + entity.x) / 2, (y + entity.y) / 2, 0.5));
					}
				}
			}
		}
	}
	
	static lock = function()
	{
		if (actions == noone) return;
		var next_action = actions[action_index];
		
		x_cache = x;
		y_cache = y;
		if (!action_rejected)
		{
			x = x_proposal;
			y = y_proposal;
		}
		else if (next_action == action.move_along) dir *= -1;
		action_complete = true;
	}
	
	static wrap_up = function()
	{
		if (actions == noone) return;
		var next_action = actions[action_index];
		
		if (next_action == action.laser_up || next_action == action.laser_down)
		{
			var offset = 0;
			var finished = false;
			while (!finished)
			{
				offset += next_action == action.laser_up ? -1 : 1;
				for (var i = 0; i < array_length(global.entities); i++)
				{
					var entity = global.entities[i];
					if (entity == self || entity.hits <= 0 || entity.evil == evil) continue;
					if (entity.x == x + projectile_offset && entity.y == y + offset)
					{
						entity.hits--;
						if (entity.hits <= 0) array_push(global.effects, new str_effect(entity.solid ? spr_spark : spr_poof, entity.x, entity.y, 1));
						else array_push(global.effects, new str_effect(spr_poof, entity.x, entity.y, 1));
						//if (entity.solid) finished = true;
					}
				}
				if (abs(offset) > 1) array_push(global.effects, new str_effect(next_action == action.laser_up ? spr_laser_up : spr_laser_down, x + projectile_offset, y + offset));
				else array_push(global.effects, new str_effect(next_action == action.laser_up ? spr_laser_start_up : spr_laser_start_down, x + projectile_offset, y + offset));
				if (y + offset <= 0 || y + offset >= HEIGHT - 1) finished = true;
			}
		}
		if (next_action == action.shoot_down || next_action == action.laser_down) projectile_offset = (projectile_offset + 1) % w;
		
		action_index = (action_index + 1) % array_length(actions);
	}
}

// Spawners

enum enemy
{
	missile,
	glider,
	saucer,
	mothership
}

function str_spawner(_turn, _type, _offset = WIDTH / 2, _range = _offset) constructor
{
	turn = _turn;
	type = _type;
	offset = _offset;
	range = _range;
	
	static spawn = function()
	{
		var pos = floor(WIDTH / 2) + irandom_range(offset, range);
		var entity = noone;
		switch (type)
		{
			case enemy.missile:
				entity = new str_entity(spr_glider, pos, -1, array_from(action.move_down));
				break;
			case enemy.glider:
				entity = new str_entity(spr_glider, pos, -1, array_from(action.move_down, action.shoot_down, action.move_along));
				break;
			case enemy.saucer:
				entity = new str_entity(spr_saucer, pos, -1, array_from(action.move_down, action.shoot_down, action.move_down, action.charge, action.laser_down, action.move_down, action.shoot_down));
				break;
			default:
				break;
		}
		if (entity != noone) array_push(global.entities, entity);
		return entity;
	}
}