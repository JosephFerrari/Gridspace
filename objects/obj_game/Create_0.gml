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
		delete active_entity;
	}
	for (var i = 0; i < ds_list_size(global.entities); i++)
	{
		var entity = global.entities[| i];
		if (entity.hits <= 0)
		{
			if (i <= index) index--;
			ds_list_delete(global.entities, i);
			delete entity;
			i--;
		}
	}
	if (index < ds_list_size(global.entities)) active_entity = global.entities[| index];
	else
	{
		if (queue_pos < array_length(queue) && queue[queue_pos].turn == turn)
		{
			active_entity = queue[queue_pos].spawn();
			queue_pos++;
		}
		else
		{
			active_entity = noone;
			turn++;
		}
	}
}

player = new str_entity(spr_player, WIDTH / 2, HEIGHT / 2);
ds_list_add(global.entities, player);

// Entity Queue

turn = 1;
queue = [];
queue_pos = 0;
array_push(queue, new str_spawner(5, enemy.glider, 0));
array_push(queue, new str_spawner(15, enemy.glider, 2));
array_push(queue, new str_spawner(15, enemy.glider, 0));
array_push(queue, new str_spawner(15, enemy.glider, -2));
array_push(queue, new str_spawner(30, enemy.glider, -3));
array_push(queue, new str_spawner(31, enemy.glider, -2));
array_push(queue, new str_spawner(32, enemy.glider, -1));
array_push(queue, new str_spawner(33, enemy.glider, 0));
array_push(queue, new str_spawner(34, enemy.glider, 1));
array_push(queue, new str_spawner(35, enemy.glider, 2));
array_push(queue, new str_spawner(36, enemy.glider, 3));