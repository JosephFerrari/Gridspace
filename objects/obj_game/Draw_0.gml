/// @description Draw Components

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
	if (transition < 0.5 || entity.hits > 0 || !entity.passed) draw_sprite_ext(spr_jet, frame % sprite_get_number(spr_jet), (xpos + 0.5) * TILE, (ypos + 0.5) * TILE, 1, entity.evil ? -1 : 1, 0, c_white, 0.5);
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