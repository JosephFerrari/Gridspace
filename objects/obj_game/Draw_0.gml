/// @description Draw Components

// Timing

var delta = delta_time / 1000000;

// Jets

for (var i = 0; i < array_length(global.entities); i++)
{
	var entity = global.entities[i];
	if (!entity.solid) continue;
	var xpos = entity.x;
	var ypos = entity.y;
	if (entity.action_rejected)
	{
		xpos = transition < 0.5 ? lerp(entity.x_cache, entity.x_proposal_cache, smooth(transition)) : lerp(entity.x_proposal_cache, entity.x, smooth(transition));
		ypos = transition < 0.5 ? lerp(entity.y_cache, entity.y_proposal_cache, smooth(transition)) : lerp(entity.y_proposal_cache, entity.y, smooth(transition));
	}
	else
	{
		xpos = lerp(entity.x_cache, entity.x, smooth(transition));
		ypos = lerp(entity.y_cache, entity.y, smooth(transition));
	}
	if (transition < 0.5 || entity.hits > 0 || !entity.passed) draw_sprite_ext(entity.evil ? spr_jet_down : spr_jet_up, frame % sprite_get_number(spr_jet_down), (xpos + 0.5) * TILE, (ypos + 0.5) * TILE, 1, 1, 0, c_white, 0.5);
}

// Non-solid Entities

for (var i = 0; i < array_length(global.entities); i++)
{
	var entity = global.entities[i];
	if (entity.solid) continue;
	var xpos = entity.x;
	var ypos = entity.y;
	if (entity.action_rejected)
	{
		xpos = transition < 0.5 ? lerp(entity.x_cache, entity.x_proposal_cache, smooth(transition)) : lerp(entity.x_proposal_cache, entity.x, smooth(transition));
		ypos = transition < 0.5 ? lerp(entity.y_cache, entity.y_proposal_cache, smooth(transition)) : lerp(entity.y_proposal_cache, entity.y, smooth(transition));
	}
	else
	{
		xpos = lerp(entity.x_cache, entity.x, smooth(transition));
		ypos = lerp(entity.y_cache, entity.y, smooth(transition));
	}
	if (transition < 0.5 || entity.hits > 0 || !entity.passed) draw_sprite(entity.spr, 0, (xpos + 0.5) * TILE, (ypos + 0.5) * TILE);
}

// Solid Entities

for (var i = 0; i < array_length(global.entities); i++)
{
	var entity = global.entities[i];
	if (!entity.solid) continue;
	var xpos = entity.x;
	var ypos = entity.y;
	if (entity.action_rejected)
	{
		xpos = transition < 0.5 ? lerp(entity.x_cache, entity.x_proposal_cache, smooth(transition)) : lerp(entity.x_proposal_cache, entity.x, smooth(transition));
		ypos = transition < 0.5 ? lerp(entity.y_cache, entity.y_proposal_cache, smooth(transition)) : lerp(entity.y_proposal_cache, entity.y, smooth(transition));
	}
	else
	{
		xpos = lerp(entity.x_cache, entity.x, smooth(transition));
		ypos = lerp(entity.y_cache, entity.y, smooth(transition));
	}
	if (transition < 0.5 || entity.hits > 0 || !entity.passed) draw_sprite(entity.spr, 0, (xpos + 0.5) * TILE, (ypos + 0.5) * TILE);
}

// Effects

for (var i = 0; i < array_length(global.effects); i++)
{
	var effect = global.effects[i];
	if (effect.persist) draw_sprite(effect.spr, frame % sprite_get_number(effect.spr), (effect.x + 0.5) * TILE, (effect.y + 0.5) * TILE);
	else if (effect.delay > 0) effect.delay -= delta * 5;
	else
	{
		effect.f += delta * 5;
		if (effect.f >= 1)
		{
			array_delete(global.effects, i, 1);
			delete effect;
			i--;
		}
		else draw_sprite(effect.spr, effect.f * sprite_get_number(effect.spr), (effect.x + 0.5) * TILE, (effect.y + 0.5) * TILE);
	}
}