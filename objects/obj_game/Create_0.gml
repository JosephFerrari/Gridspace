/// @description Initialize Variables

// Constants

#macro TILE 16
#macro WIDTH 7
#macro HEIGHT 11

// Structs

function str_entity(_x, _y, _spr) constructor
{
    x = floor(_x);
    y = floor(_y);
	spr = _spr;
	w = sprite_get_width(spr) / TILE;
	h = sprite_get_height(spr) / TILE;
	
	static move = function(_x, _y)
	{
		x = clamp(x + _x, 0, WIDTH - w);
		y = clamp(y + _y, 0, HEIGHT - h);
	}
}

// Entities

entities = ds_list_create();
player = new str_entity(WIDTH / 2, HEIGHT / 2, spr_player);
ds_list_add(entities, player);