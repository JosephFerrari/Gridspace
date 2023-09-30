/// @description Draw Components

// Entities

for (var i = 0; i < ds_list_size(global.entities); i++)
{
	var entity = global.entities[| i];
	var xpos = entity.x;
	var ypos = entity.y;
	if (transition > 0 && entity == active_entity)
	{
		var bounce = transition > 0.5 && (entity.x != entity.x_proposal || entity.y != entity.y_proposal);
		xpos = bounce ? lerp(entity.x_proposal, entity.x_cache, smooth(transition)) : lerp(entity.x_cache, entity.x_proposal, smooth(transition));
		ypos = bounce ? lerp(entity.y_proposal, entity.y_cache, smooth(transition)) : lerp(entity.y_cache, entity.y_proposal, smooth(transition));
	}
	draw_sprite(entity.spr, 0, xpos * TILE, ypos * TILE);
}