/// @description Draw Components

// Entities

for (var i = 0; i < array_length(global.entities); i++)
{
	var entity = global.entities[i];
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
	if (transition < 0.5 || entity.hits > 0 || !entity.passed) draw_sprite(entity.spr, 0, xpos * TILE, ypos * TILE);
}