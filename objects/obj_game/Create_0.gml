/// @description Initialize Variables

// Constants

#macro TILE 16
#macro WIDTH 7
#macro HEIGHT 11

// Entity Pool

global.entities = ds_list_create();
active_entity = noone;
transition = 0;


function next_entity()
{
	var index = ds_list_find_index(global.entities, active_entity) + 1;
	if (active_entity.y < 0 || active_entity.y + active_entity.h > HEIGHT)
	{
		index--;
		ds_list_delete(global.entities, index);
	}
	for (var i = 0; i < ds_list_size(global.entities); i++)
	{
		var entity = global.entities[| i];
		show_debug_message(entity);
		if (entity.hits <= 0)
		{
			if (i <= index) index--;
			ds_list_delete(global.entities, i);
			i--;
		}
	}
	if (index < ds_list_size(global.entities)) active_entity = global.entities[| index];
	else
	{
		active_entity = noone;
		transition = 0;
	}
}

player = new str_entity(WIDTH / 2, HEIGHT / 2, spr_player);
ds_list_add(global.entities, player);
ds_list_add(global.entities, spawn_glider(1));