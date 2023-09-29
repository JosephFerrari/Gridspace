/// @description Draw Components

// Entities

for (var i = 0; i < ds_list_size(entities); i++)
{
	var entity = entities[| i];
	draw_sprite(entity.spr, 0, entity.x * TILE, entity.y * TILE);
}